xml.instruct!
xml.setgame do
  xml.field_size       @game.field.length
  xml.remaining        number_noun_desc(@game.deck.facedown.length,'card')
  xml.status           "unchanged"
  if flash[:notice]
    xml.notice         formatted_date(Time.now) + ': ' + flash[:notice]
  end
  if flash[:error]
    xml.error          formatted_date(Time.now) + ': ' + flash[:error]
  end
  xml.num_sets         number_noun_desc(@sets.length, 'set')
end
