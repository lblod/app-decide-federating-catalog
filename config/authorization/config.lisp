;;;;;;;;;;;;;;;;;;;
;;; delta messenger
(in-package :delta-messenger)

;; (push (make-instance 'delta-logging-handler) *delta-handlers*) ;; enable if delta messages should be logged on terminal
(add-delta-messenger "http://delta-notifier/")
(setf *log-delta-messenger-message-bus-processing* nil) ;; set to t for extra messages for debugging delta messenger

;;;;;;;;;;;;;;;;;
;;; configuration
(in-package :client)
(setf *log-sparql-query-roundtrip* t) ; change nil to t for logging requests to virtuoso (and the response)
(setf *backend* "http://triplestore:8890/sparql")

(in-package :server)
(setf *log-incoming-requests-p* nil) ; change nil to t for logging all incoming requests

;;;;;;;;;;;;;;;;
;;; prefix types
(in-package :type-cache)

(add-type-for-prefix "http://mu.semte.ch/sessions/" "http://mu.semte.ch/vocabularies/session/Session") ; each session URI will be handled for updates as if it had this mussession:Session type

;;;;;;;;;;;;;;;;;
;;; access rights

(in-package :acl)

;; these three reset the configuration, they are likely not necessary
(defparameter *access-specifications* nil)
(defparameter *graphs* nil)
(defparameter *rights* nil)

;; Prefixes used in the constraints below (not in the SPARQL queries)
(define-prefixes
  ;; Core
  :mu "http://mu.semte.ch/vocabularies/core/"
  :session "http://mu.semte.ch/vocabularies/session/"
  :ext "http://mu.semte.ch/vocabularies/ext/"
  ;; App
  :dcat "http://www.w3.org/ns/dcat#"
  :dct "http://purl.org/dc/terms/"
  :foaf "http://xmlns.com/foaf/0.1/"
  :odrl "http://www.w3.org/ns/odrl/2/"
  :schema "https://schema.org/"
  :sh "http://www.w3.org/ns/shacl#"
  :skos "http://www.w3.org/2004/02/skos/core#")


;;;;;;;;;
;; Graphs

(define-graph abb-ldes-public ("http://mu.semte.ch/graphs/ldes/abb/public")
  ;; DCAT data
  ("dcat:Catalog" -> _)
  ("dcat:Dataset" -> _)
  ("dcat:Distribution" -> _)
  ("dcat:DataService" -> _)
  ("dcat:CatalogRecord" -> _)
  ("skos:Concept" -> _)
  ("skos:ConceptScheme" -> _)
  ("foaf:Agent" -> _)
  ;; ODRL Offers and authorisation policy
  ("odrl:Asset" -> _)
  ("odrl:AssetCollection" -> _)
  ("odrl:Offer" -> _)
  ("odrl:Party" -> _)
  ("odrl:PartyCollection" -> _)
  ("odrl:Permission" -> _)
  ("odrl:Prohibition" -> _)
  ("odrl:Set" -> _)
  ("schema:Offer" -> _)
  ("schema:HowTo" -> _)
  ;; SHACL shapes
  ("sh:NodeShape" -> _)
  ("sh:PropertyShape" -> _))

(define-graph bamberg-ldes-public ("http://mu.semte.ch/graphs/ldes/bamberg/public")
  ;; DCAT data
  ("dcat:Catalog" -> _)
  ("dcat:Dataset" -> _)
  ("dcat:Distribution" -> _)
  ("dcat:DataService" -> _)
  ("dcat:CatalogRecord" -> _)
  ("skos:Concept" -> _)
  ("skos:ConceptScheme" -> _)
  ("foaf:Agent" -> _)
  ;; ODRL Offers and authorisation policy
  ("odrl:Asset" -> _)
  ("odrl:AssetCollection" -> _)
  ("odrl:Offer" -> _)
  ("odrl:Party" -> _)
  ("odrl:PartyCollection" -> _)
  ("odrl:Permission" -> _)
  ("odrl:Prohibition" -> _)
  ("odrl:Set" -> _)
  ("schema:Offer" -> _)
  ("schema:HowTo" -> _)
  ;; SHACL shapes
  ("sh:NodeShape" -> _)
  ("sh:PropertyShape" -> _))

(define-graph freiburg-ldes-public ("http://mu.semte.ch/graphs/ldes/freiburg/public")
  ;; DCAT data
  ("dcat:Catalog" -> _)
  ("dcat:Dataset" -> _)
  ("dcat:Distribution" -> _)
  ("dcat:DataService" -> _)
  ("dcat:CatalogRecord" -> _)
  ("skos:Concept" -> _)
  ("skos:ConceptScheme" -> _)
  ("foaf:Agent" -> _)
  ;; ODRL Offers and authorisation policy
  ("odrl:Asset" -> _)
  ("odrl:AssetCollection" -> _)
  ("odrl:Offer" -> _)
  ("odrl:Party" -> _)
  ("odrl:PartyCollection" -> _)
  ("odrl:Permission" -> _)
  ("odrl:Prohibition" -> _)
  ("odrl:Set" -> _)
  ("schema:Offer" -> _)
  ("schema:HowTo" -> _)
  ;; SHACL shapes
  ("sh:NodeShape" -> _)
  ("sh:PropertyShape" -> _))

(define-graph ghent-ldes-public ("http://mu.semte.ch/graphs/ldes/ghent/public")
  ;; DCAT data
  ("dcat:Catalog" -> _)
  ("dcat:Dataset" -> _)
  ("dcat:Distribution" -> _)
  ("dcat:DataService" -> _)
  ("dcat:CatalogRecord" -> _)
  ("skos:Concept" -> _)
  ("skos:ConceptScheme" -> _)
  ("foaf:Agent" -> _)
  ;; ODRL Offers and authorisation policy
  ("odrl:Asset" -> _)
  ("odrl:AssetCollection" -> _)
  ("odrl:Offer" -> _)
  ("odrl:Party" -> _)
  ("odrl:PartyCollection" -> _)
  ("odrl:Permission" -> _)
  ("odrl:Prohibition" -> _)
  ("odrl:Set" -> _)
  ("schema:Offer" -> _)
  ("schema:HowTo" -> _)
  ;; SHACL shapes
  ("sh:NodeShape" -> _)
  ("sh:PropertyShape" -> _))


;;;;;;;;;;;;;
;; User roles

(supply-allowed-group "public")


;;;;;;;;;
;; Grants

(grant (read)
       :to-graph abb-ldes-public
       :for-allowed-group "public")

(grant (read)
       :to-graph bamberg-ldes-public
       :for-allowed-group "public")

(grant (read)
       :to-graph freiburg-ldes-public
       :for-allowed-group "public")

(grant (read)
       :to-graph ghent-ldes-public
       :for-allowed-group "public")
