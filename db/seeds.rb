tags = ['Drinks', 'Church', 'Photos',
        'Lights', 'Decoration', 'Invitation',
        'Outfits', 'Best Man/Mademoiselle',
        'Consulting', 'Music', 'Valet', 'Extra']

tags.each do |t|
  Tag.create(name: t)
end
