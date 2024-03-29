defmodule HergettoWeb.ErrorView do
  use HergettoWeb, :view
  import HergettoWeb.Helpers.MetaTags
  alias HergettoWeb.Components.Navbar
  alias HergettoWeb.Components.LogoIcon

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.html", _assigns) do
  #   "Internal Server Error"
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.html" becomes
  # "Not Found".
  def template_not_found(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
