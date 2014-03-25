module DashboardHelper
  def format_menu(diabetics, account)
    result = ['Select a diabetic or an account']
    result += diabetics.map {|diabetic| "Diabetic: #{diabetic.name} -- #{diabetic.id} "}
    result << "Account: #{current_account.username}"
    result
  end
end
