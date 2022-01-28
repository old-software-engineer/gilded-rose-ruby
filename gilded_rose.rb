require_relative('item')
require_relative('common_item')
require_relative('aged_brie')
require_relative('backstage')
require_relative('sulfuras')
require_relative('conjured_item')

class GildedRose
  ITEM_CLASS = {
    'Aged Brie' => AgedBrie,
    'Sulfuras, Hand of Ragnaros' => Sulfuras,
    'Backstage passes to a TAFKAL80ETC concert' => Backstage
  }.freeze

  def initialize(items)
    @items = items.map { |item| class_from(name: item.name).new(item) }
  end

  def update_quality
    @items.each(&:update)

    self
  end

  private

  def class_from(name:)
    return ConjuredItem if name.downcase.start_with?('conjured ')

    ITEM_CLASS[name] || CommonItem
  end
end
