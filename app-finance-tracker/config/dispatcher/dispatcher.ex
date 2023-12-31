defmodule Dispatcher do
  use Matcher
  define_accept_types [
    html: [ "text/html", "application/xhtml+html" ],
    json: [ "application/json", "application/vnd.api+json" ]
  ]

  @any %{}
  @json %{ accept: %{ json: true } }
  @html %{ accept: %{ html: true } }

  define_layers [ :static, :services, :fall_back, :not_found ]

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule:
  #
  # match "/themes/*path", @json do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end
  #
  # Run `docker-compose restart dispatcher` after updating
  # this file.

  match "/accounts/*path", @any do
    Proxy.forward conn, path, "http://registration/accounts/"
  end

  match "/sessions/*path", @any do
    Proxy.forward conn, path, "http://login/sessions/"
  end

  match "/stats/*path", @any do
    Proxy.forward conn, path, "http://stats/"
  end

  # RESOURCES

  match "/expenses/*path" do
    Proxy.forward conn, path, "http://resource/expenses/"
  end

  match "/users/*path" do
    Proxy.forward conn, path, "http://resource/users/"
  end

  match "/useraccounts/*path" do
    Proxy.forward conn, path, "http://resource/useraccounts/"
  end

  match "/roles/*path" do
    Proxy.forward conn, path, "http://resource/roles/"
  end

  # Page not found

  match "/*_", %{ layer: :not_found } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end
end
