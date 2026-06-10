defmodule Dispatcher do
  use Matcher
  define_accept_types [
    html: [ "text/html", "application/xhtml+html" ],
    json: [ "application/json", "application/vnd.api+json" ],
    any: ["*/*"]
  ]

  @any %{}
  @json %{ accept: %{ json: true } }
  @html %{ accept: %{ html: true } }

  define_layers [ :static, :sparql, :services, :resources, :frontend, :not_found ]

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
  # API Services
  #################
  match "/api/sparql", %{ accept: [:any], layer: :sparql } do
    Proxy.forward conn, [], "http://database:8890/sparql"
  end

  ###############################################################
  # LDES
  ###############################################################
  match "/ldes/*path", %{ accept: %{any: true}, layer: :services} do
    Proxy.forward conn, path, "http://ldes-serve-feed/"
  end

  #################
  # RESOURCES
  #################
  match "/datasets/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/datasets/"
  end

  match "/catalogs/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/catalogs/"
  end

  match "/distributions/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/distributions/"
  end

  match "/catalog-records/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/catalog-records/"
  end

  match "/concepts/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/concepts/"
  end

  match "/concept-schemes/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/concept-schemes/"
  end

  match "/agents/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/agents/"
  end

  match "/formats/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/formats/"
  end

  match "/pages/*path", %{ accept: [:json], layer: :resources } do
    Proxy.forward conn, path, "http://cache/pages/"
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
