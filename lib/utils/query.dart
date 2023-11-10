const String getuser = """
query GetUser(\$email: String!, \$password: String!) {
  streamify_mst_users(where: { Email: { _eq: \$email }, Password: { _eq: \$password } }) {
    user_id
    Username
    Email
    Password
    Subscription_Id
  }
}
""";

const String getCategories = """

query GetStreamifyMstCategories {
  streamify_mst_categories {
    Category_ID
		Category_Name
		Category_Image
  }
}
    
""";

const String get_mst_movies = """

query GetStreamifyMstMovies(\$mst_categories: uuid!) {
  streamify_mst_movies(where: {mst_categories: {_eq: \$mst_categories}}) {
    Name
    description
    image
    id
    video
    Title_Poster
    mst_categories
  }
}

""";

const String getSeries = """

query MyQuery {
  streamify_mst_series {
    Series_ID
    Series_Title
    descriptions
    poster
    Title_Poster
  }
}
""";

const String getSeasons = """
query MyQuery(\$series_id: uuid!) {
  mst_seasons(where: {series_id: {_eq: \$series_id}}) {
    season_number
    season_id
    series_id
  }
}

""";
const String get_mst_Plans = """

query GetStreamifyMstPlans {
  streamify_mst_plans {
    Plan_ID
    Plan_Name
    Price
    Number_of_Screens
    Video_Quality
    Concurrent_Streams
  }
}

""";

const String getEpisode = """
query MyQuery (\$season_id:uuid){
  streamify_mst_episodes(where: {season_id: {_eq: \$season_id}}) {
    Episode_ID
    Episode_Number
    Series_ID
    Title
    link
    Episode_Poster
    season_id
  }
}

""";

const String getMyList = """
query GetStreamifyMstMovies {
  streamify_mst_movies {
       id
		mst_categories
		Name
		image
		description
		video
    Title_Poster
		
  }
}
""";

const String searchMoviesByName = """
query SearchMoviesByName(\$name: String!) {
  streamify_mst_movies(where: {Name: {_ilike: \$name}}) {
    Name
    description
    image
    video
    id
    Title_Poster
    mst_categories
  }
}
""";

const String searchSeriesByName = """

query SearchSeriesByName(\$title: String!) {
  streamify_mst_series(where: {Series_Title: {_ilike: \$title}}) {
    Current_Season
    Series_Title
    Total_Seasons
    descriptions
    poster
    Series_ID
    Title_Poster
  }
}
""";

const String getBanner = """
query GetStreamifyMstBanners {
  streamify_mst_banners {
    banner_id
		banner_image
		banner_name
		banner_video
		banner_sub_name
       banner_description
  }
}
""";

const String getFavorites = """
query MyQuery {
  streamify_mst_favorites {
    favorite_movies
    id
    favorites_list {
      Name
      Title_Poster
      description
      favorites_status
      id
      image
    }
  }
}

""";

const String insertFavorites = """
mutation InsertStreamifyMstFavorites(\$favorite_movies: uuid) {
  insert_streamify_mst_favorites(objects: {favorite_movies: \$favorite_movies}) {
    affected_rows
    returning {
      favorite_movies
			id
    }
  }
}
""";
