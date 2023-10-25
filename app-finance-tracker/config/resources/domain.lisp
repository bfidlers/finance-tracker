(in-package :mu-cl-resources)

(setf *include-count-in-paginated-responses* t)
(setf *supply-cache-headers-p* t)
(setf sparql:*experimental-no-application-graph-for-sudo-select-queries* t)
(setf *cache-model-properties-p* t)

(define-resource book ()
  :class (s-prefix "schema:Book")
  :properties `((:title :string ,(s-prefix "schema:headline"))
                (:isbn :string ,(s-prefix "schema:isbn"))
                (:publication-date :date ,(s-prefix "schema:datePublished"))
                (:genre :string ,(s-prefix "schema:genre"))
                (:language :string ,(s-prefix "schema:inLanguage")) 
                (:number-of-pages :integer ,(s-prefix "schema:numberOfPages")))
  :has-one `((author :via ,(s-prefix "schema:author") 
              :as "author"))
  :resource-base (s-url "http://mu.semte.ch/services/github/madnificent/book-service/books/")
:on-path "books")

(define-resource author ()
  :class (s-prefix "schema:Author")
  :properties `((:name :string ,(s-prefix "schema:name")))
  :has-many `((book :via ,(s-prefix "schema:author")
               :inverse t
               :as "books"))
  :resource-base (s-url "http://mu.semte.ch/services/github/madnificent/book-service/authors/")
:on-path "authors")

(define-resource expense ()
  :class (s-prefix "ext:Expense")
  :properties `((:name :string ,(s-prefix "ext:name"))
                (:amount :integer ,(s-prefix "ext:amount")))
  :resource-base (s-url "http://mu.semte.ch/services/github/madnificent/book-service/expenses/")
:on-path "expenses")

(define-resource user ()
  :class (s-prefix "foaf:Person")
  :properties `((:name :string ,(s-prefix "foaf:name"))
                (:created :dateTime ,(s-prefix "dct:created"))
                (:modified :dateTime ,(s-prefix "dct:modified")))
  :resource-base (s-url "http://mu.semte.ch/services/registration-service/users/")
:on-path "users")

(define-resource useraccount ()
  :class (s-prefix "foaf:OnlineAccount")
  :properties `((:accountname :string ,(s-prefix "foaf:accountName"))
                (:password :string ,(s-prefix "account:password"))
                (:salt :string ,(s-prefix "account:salt"))
                (:status :url ,(s-prefix "account:status"))
                (:created :dateTime ,(s-prefix "dct:created"))
                (:modified :dateTime ,(s-prefix "dct:modified")))
  :resource-base (s-url "http://mu.semte.ch/services/registration-service/accounts/")
:on-path "useraccounts")

;; reading in the domain.json
(read-domain-file "domain.json")
