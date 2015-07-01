class AddBrandingColumnsToCompany < ActiveRecord::Migration
  def change
    add_column(:companies, :logo, :string)
    add_column(:companies, :primary_color, :string)
    add_column(:companies, :secondary_color, :string)
  end
end
