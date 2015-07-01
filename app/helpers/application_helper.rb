module ApplicationHelper

  def company_dropdown
    Company.all.map { |company| [company.name, company.id] }.sort
  end

end



