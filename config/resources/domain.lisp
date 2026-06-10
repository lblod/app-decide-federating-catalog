;; NOTE (08/06/2026): This is an unmodified, except for this note, default config.  It will be
;; edited when more functionality is added to the app, e.g. frontends.
(in-package :mu-cl-resources)

(setf *include-count-in-paginated-responses* t)
(setf *supply-cache-headers-p* t)
(setf sparql:*experimental-no-application-graph-for-sudo-select-queries* t)
(setf *cache-model-properties-p* t)
(setf mu-support::*use-custom-boolean-type-p* nil)
(setq *cache-count-queries-p* t)
(setf sparql:*query-log-types* '(:default :update-group :update :query :ask))

(read-domain-file "dcat.lisp")
