class GildedRose

  attr_accessor :items

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if not_a_special_item?(item) && item.sell_in > 0
        item.sell_in -= 1
        item.quality = item.quality - 1 unless item.quality == 0
      elsif not_a_special_item?(item) && item.sell_in <= 0
        item.sell_in -= 1
        item.quality -= 2 unless item.quality == 0
      elsif aged_brie?(item) && item.quality < 50
        item.sell_in -= 1
        item.quality += 1
      elsif aged_brie?(item) && item.quality == 50
        item.sell_in -= 1
      elsif sulfuras?(item)
        item.sell_in = "not applicable"
      end
    end
  end

  private

  def not_a_special_item?(item)
    item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" && item.name != "Sulfuras, Hand of Ragnaros"
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
