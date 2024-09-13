# app/models/proposal.rb

class Proposal < ApplicationRecord
  include AASM
  has_paper_trail

  belongs_to :user
  belongs_to :project

  has_many :comments, dependent: :destroy
  has_many_attached :documents

  validates :title, :description, presence: true
  validates :status, presence: true, inclusion: { in: %w[accepted under_review approved rejected scheduled] }

  before_validation :set_default_status, on: :create
  validate :acceptable_documents

  aasm column: 'status' do
    state :accepted, initial: true
    state :under_review
    state :approved
    state :rejected
    state :scheduled

    event :submit_review do
      transitions from: :accepted, to: :under_review, after: :notify_status_change
    end

    event :approve do
      transitions from: [:under_review, :accepted], to: :approved, after: :notify_status_change
    end

    event :reject do
      transitions from: [:under_review, :accepted], to: :rejected, after: :notify_status_change
    end

    event :schedule do
      transitions from: :approved, to: :scheduled, after: :notify_status_change
    end
  end

  after_update :notify_if_status_changed, if: :saved_change_to_status?

  def self.to_csv
    attributes = %w{id title description status user_email project_name created_at updated_at}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.includes(:user, :project).find_each do |proposal|
        csv << [
          proposal.id,
          proposal.title,
          proposal.description,
          proposal.status,
          proposal.user.email,
          proposal.project.name,
          proposal.created_at,
          proposal.updated_at
        ]
      end
    end
  end

  def send_approval_request
    message = {
      channel: '#approvals', # Replace with your Slack channel
      text: "A new proposal requires your approval:",
      attachments: [
        {
          text: "Proposal: *#{title}*",
          fallback: "Approve or Reject Proposal",
          callback_id: 'approve_proposal',
          actions: [
            {
              name: 'approve',
              text: 'Approve',
              type: 'button',
              value: id.to_s
            },
            {
              name: 'reject',
              text: 'Reject',
              type: 'button',
              value: id.to_s
            }
          ]
        }
      ]
    }
    Slack::Web::Client.new.chat_postMessage(message)
  rescue Slack::Web::Api::Errors::SlackError => e
    Rails.logger.error "Slack approval request failed: #{e.message}"
  end

  private

  def set_default_status
    self.status ||= 'accepted'
  end

  def acceptable_documents
    return unless documents.attached?

    documents.each do |document|
      unless document.content_type.in?(%w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document])
        errors.add(:documents, "must be a PDF or Word document")
      end

      unless document.byte_size <= 10.megabytes
        errors.add(:documents, "is too big (max 10MB)")
      end
    end
  end

  def notify_status_change
    notify_if_status_changed
  end

  def notify_if_status_changed
    message = "Proposal *#{title}* status changed to *#{status.capitalize}*."
    SlackNotifier.notify(channel: '#general', text: message) # Change '#general' to your desired channel
  end
end
