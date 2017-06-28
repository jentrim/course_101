hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

hsh.each_with_object([]) do |(_, value), array|
  if value[:type] == 'fruit'
    array.push(value[:colors].map{|color| color.capitalize})
  elsif value[:type] == 'vegetable'
    array.push(value[:size].upcase)
  end
end

