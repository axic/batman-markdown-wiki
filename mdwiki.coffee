class Mdwiki extends Batman.App
  # The core text processor
  @Wikidown = (input) ->
    # process wiki links first
    # this isn't the most elegant way though
    input = input.replace /\[\[[^\]]+\]\]/g, (match) ->
      # extract the key itself (for now drop the outside brackets)
      match = match.replace /[\[\]]/g, ''

      "<a href=\"#!/page/#{match}\">#{match}</a>"

    # use Markdown processor
    Markdown(input)

  # Make Mdwiki available in the global namespace so it can be used
  # as a namespace and bound to in views.
  @global yes

  # Load model
  @model 'wiki'

  # Set up routes
  @route 'page/:title', 'app#page'

  # Source the AppController and set the root route to AppController#index.
  @controller 'app'
  @root 'app#index'
