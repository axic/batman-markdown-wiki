class Mdwiki.AppController extends Batman.Controller
  index: ->
    # create index if not present
    Wiki.find 'index', (err, page) ->
      if err
        new Wiki(title: 'index', body: 'Welcome to [[Markdown]] Wiki!').save()

    # Move to default page
    @dispatch 'page', title: 'index'

  # our main action (as well as the only view we have)
  page: (params) ->
     @wiki = Wiki.find params.title, (err, page) ->
        page

  startEditing: (node, event, context) ->
    wiki = context.get('wiki')
    editing = wiki.set('editing', true)

  save: (node, event, context) ->
    wiki = context.get('wiki')
    wiki.save (err, page) ->
      throw err if err && !err instanceof Batman.ErrorSet
    wiki.set('editing', false)

  remove: (node, event, context) ->
    wiki = context.get('wiki')
    wiki.destroy (err, page) ->
      throw err if err
    wiki.set('editing', false)

    # reload (FIXME)
    @dispatch 'page', title: wiki.title
