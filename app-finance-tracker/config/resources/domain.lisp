(in-package :mu-cl-resources)

(setf *include-count-in-paginated-responses* t)
(setf *supply-cache-headers-p* t)
(setf sparql:*experimental-no-application-graph-for-sudo-select-queries* t)
(setf *cache-model-properties-p* t)

(define-resource user ()
  :class (s-prefix "foaf:Person")
  :properties `((:name :string ,(s-prefix "foaf:name"))
                (:created :dateTime ,(s-prefix "dct:created"))
                (:modified :dateTime ,(s-prefix "dct:modified"))
                (:birthdate :date ,(s-prefix "schema:birthDate")))
  :has-many `((useraccount :via ,(s-prefix "foaf:account")
               :as "accounts"))
  :resource-base (s-url "http://mu.semte.ch/services/registration-service/users/")
:on-path "users")

(define-resource useraccount ()
  :class (s-prefix "foaf:OnlineAccount")
  :properties `((:accountname :string ,(s-prefix "foaf:accountName"))
                (:password :string ,(s-prefix "account:password"))
                (:salt :string ,(s-prefix "account:salt"))
                (:status :url ,(s-prefix "account:status"))
                (:created :dateTime ,(s-prefix "dct:created"))
                (:modified :dateTime ,(s-prefix "dct:modified"))
                (:email :string ,(s-prefix "schema:email")))
  :has-one `((user :via ,(s-prefix "foaf:account")
              :inverse t
              :as "user"))
  :has-many `((expense :via ,(s-prefix "ext:expense")
               :as "expenses")
              (role :via ,(s-prefix "ext:role")
              :as "roles"))
  :resource-base (s-url "http://mu.semte.ch/services/registration-service/accounts/")
:on-path "useraccounts")

(define-resource role ()
  :class (s-prefix "ext:Role")
  :properties `((:rolename :string ,(s-prefix "ext:name")))
  :has-many `((useraccount :via ,(s-prefix "ext:role")
              :inverse t
              :as "accounts"))
  :resource-base (s-url "http://finance-tracker/roles/")
:on-path "roles")

(define-resource expense ()
  :class (s-prefix "ext:Expense")
  :properties `((:name :string ,(s-prefix "ext:name"))
                (:amount :float ,(s-prefix "ext:amount"))
                (:date :date ,(s-prefix "ext:date"))
                (:description :string ,(s-prefix "ext:description"))
                (:category :string ,(s-prefix "ext:category"))
                (:payment-method :string ,(s-prefix "ext:paymentMethod"))
                (:currency :string ,(s-prefix "ext:currency"))
                (:location :string ,(s-prefix "ext:location"))
                (:created :dateTime ,(s-prefix "dct:created"))
                (:modified :dateTime ,(s-prefix "dct:modified")))
  :has-one `((useraccount :via ,(s-prefix "ext:expense")
              :inverse t
              :as "user"))
  :resource-base (s-url "http://finance-tracker/expenses/")
:on-path "expenses")

;; reading in the domain.json
(read-domain-file "domain.json")
