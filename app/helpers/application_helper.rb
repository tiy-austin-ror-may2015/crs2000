module ApplicationHelper

  def company_dropdown
    Company.all.map { |company| [company.name, company.id] }.sort
  end

  def company_logo
    current_company.logo if current_employee
  end

  def primary_color
    current_company.primary_color if current_employee
  end

  def secondary_color
    current_company.secondary_color if current_employee
  end

   def add_class_if(path_to_turn_on, class_name)
    class_name if request.fullpath == path_to_turn_on
  end
end



