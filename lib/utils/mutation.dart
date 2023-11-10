const String insertUser = """
mutation InsertStreamifyMstUsers(\$Username: String, \$Email: String, \$Password: String) {
  insert_streamify_mst_users(objects: {Username: \$Username, Email: \$Email, Password: \$Password}) {
    affected_rows
    returning {
      user_id
			Username
			Email
			Password
    }
  }
}

""";
