module Request.Base exposing (makeRequest)

import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Task exposing (Task)


makeRequest : SelectionSet decodesTo RootQuery -> Task (Graphqelm.Http.Error decodesTo) decodesTo
makeRequest query =
    query
        |> Graphqelm.Http.queryRequest "http://localhost:8000/graphql"
        |> Graphqelm.Http.withHeader "authorization" "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjamhodXUyaHA1c2o1MGI2MjJtcmVjcWtjIiwiaWF0IjoxNTI3MDA0MTMzfQ.k615sHbHSzgU7nE90ue5iql8x1Z63Ua8mvzj_wwkr6s"
        |> Graphqelm.Http.toTask
