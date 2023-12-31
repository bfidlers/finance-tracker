alias Acl.Accessibility.Always, as: AlwaysAccessible
alias Acl.Accessibility.ByQuery, as: AccessByQuery
alias Acl.GraphSpec.Constraint.Resource.AllPredicates, as: AllPredicates
alias Acl.GraphSpec.Constraint.Resource.NoPredicates, as: NoPredicates
alias Acl.GraphSpec.Constraint.ResourceFormat, as: ResourceFormatConstraint
alias Acl.GraphSpec.Constraint.Resource, as: ResourceConstraint
alias Acl.GraphSpec, as: GraphSpec
alias Acl.GroupSpec, as: GroupSpec
alias Acl.GroupSpec.GraphCleanup, as: GraphCleanup

defmodule Acl.UserGroups.Config do
  def user_groups do
    # These elements are walked from top to bottom.  Each of them may
    # alter the quads to which the current query applies.  Quads are
    # represented in three sections: current_source_quads,
    # removed_source_quads, new_quads.  The quads may be calculated in
    # many ways.  The useage of a GroupSpec and GraphCleanup are
    # common.
    [
      # # // Registration + Login Service
      # %GroupSpec{
      #   name: "registration",
      #   useage: [:read, :write, :read_for_write],
      #   access: %AlwaysAccessible{},
      #   graphs: [ %GraphSpec{
      #               graph: "http://mu.semte.ch/application",
      #               constraint: %ResourceConstraint{
      #                 resource_types: [
      #                   "http://xmlns.com/foaf/0.1/Person",
      #                   "http://xmlns.com/foaf/0.1/OnlineAccount",
      #                 ],
      #                 inverse_predicates: %AllPredicates{}
      #               } } ] },

      # // PUBLIC
      %GroupSpec{
        name: "public",
        useage: [:read, :write, :read_for_write],
        access: %AlwaysAccessible{},
        graphs: [ %GraphSpec{
                    graph: "http://mu.semte.ch/graphs/public",
                    constraint: %ResourceConstraint{
                      resource_types: [
                        "http://xmlns.com/foaf/0.1/Person",
                        "http://xmlns.com/foaf/0.1/OnlineAccount",
                        "http://mu.semte.ch/vocabularies/ext/Role",
                      ],
                      inverse_predicates: %AllPredicates{}
                    } } ] },

      %GroupSpec{
        name: "expenses",
        useage: [:read, :write, :read_for_write],
        access: %AlwaysAccessible{},
        graphs: [ %GraphSpec{
                    graph: "http://mu.semte.ch/graphs/expenses",
                    constraint: %ResourceConstraint{
                      resource_types: [
                        "http://mu.semte.ch/vocabularies/ext/Expense",
                      ],
                      inverse_predicates: %AllPredicates{}
                    } } ] },

      # // CLEANUP
      #
      %GraphCleanup{
        originating_graph: "http://mu.semte.ch/application",
        useage: [:write],
        name: "clean"
      }
    ]
  end
end
