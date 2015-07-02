module ApplicationHelper

  def company_dropdown
    Company.all.map { |company| [company.name, company.id] }.sort
  end

  def company_logo
    current_employee.company.logo if current_employee
  end

  def primary_color
    current_employee.company.primary_color if current_employee
  end

  def secondary_color
    current_employee.company.secondary_color if current_employee
  end

end



