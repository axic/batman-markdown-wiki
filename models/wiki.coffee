class Mdwiki.Wiki extends Batman.Model
  @persist Batman.LocalStorage

  @global yes

  @primaryKey: 'title'

  @encode 'title', 'body'
  @validate 'title', 'body', presence: true

  @accessor 'formatted', ->
    Mdwiki.Wikidown(@get('body'))

  @accessor 'empty', ->
    @get('body').length == 0

  title: ''
  body: ''
