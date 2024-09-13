# app/helpers/application_helper.rb

module ApplicationHelper
  def status_badge(status)
    case status
    when 'accepted'
      'bg-green-100 text-green-800'
    when 'under_review'
      'bg-yellow-100 text-yellow-800'
    when 'approved'
      'bg-blue-100 text-blue-800'
    when 'scheduled'
      'bg-purple-100 text-purple-800'
    when 'rejected'
      'bg-red-100 text-red-800'
    else
      'bg-gray-100 text-gray-800'
    end
  end
end
