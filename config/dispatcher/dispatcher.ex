defmodule Dispatcher do
  use Matcher
  define_accept_types [
    html: [ "text/html", "application/xhtml+html" ],
    json: [ "application/json", "application/vnd.api+json" ]
  ]

  @any %{}
  @json %{ accept: %{ json: true } }
  @html %{ accept: %{ html: true } }

  define_layers [ :static, :services, :resources, :frontend, :not_found ]

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule:
  #
  # match "/themes/*path", @json do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end
  #
  # Run `docker-compose restart dispatcher` after updating
  # this file.

  #################
  # RESOURCES
  #################
  match "/datasets/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/datasets/"
  end

  match "/catalogs/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/catalogs/"
  end

  match "/distributions/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/distributions/"
  end

  match "/catalog-records/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/catalog-records/"
  end

  match "/concepts/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/concepts/"
  end

  match "/concept-schemes/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/concept-schemes/"
  end

  match "/agents/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/agents/"
  end

  match "/formats/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/formats/"
  end

  match "/pages/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://resource/pages/"
  end

  ###############
  # STATIC
  ###############
  # dcat
  match "/dcat/*path", %{ accept: [:any], layer: :services } do
    forward(conn, path, "http://dcat/")
  end

  match "/index.html",  %{reverse_host: ["ds" | _rest], layer: :static} do
    forward(conn, [], "http://frontend-dcat/index.html")
  end

  get "/assets/*path", %{reverse_host: ["ds" | _rest], layer: :static} do
    forward(conn, path, "http://frontend-dcat/assets/")
  end

  get "/@appuniversum/*path",  %{reverse_host: ["ds" | _rest], layer: :static} do
    forward(conn, path, "http://frontend-dcat/@appuniversum/")
  end

  #################
  # Frontends
  #################
  match "/*_path", %{reverse_host: ["ds" | _rest], accept: %{html: true}, layer: :frontend} do
    forward(conn, [], "http://frontend-dcat/index.html")
  end

  match "/*_", %{ layer: :not_found } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end
end
