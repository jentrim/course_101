def joinor(arr, delimeter = ', ', word = 'or ')
  terms = arr.length
  if terms > 2
    arr[-1] = word + arr[-1].to_s
    arr.join(delimeter)
  elsif terms == 2
    arr.join(' ' + word)
  else
    arr.join(delimeter)
  end
end
  