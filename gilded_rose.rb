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
        aged_brie_quality_check(item)
      elsif aged_brie?(item) && item.quality == 50
        item.sell_in -= 1
      elsif sulfuras?(item)
      elsif backstage_passes?(item)
        passes_sell_in_check(item) unless is_quality_fifty?(item)
        item.quality = 0 if item.sell_in <= 0
        item.sell_in -= 1
      elsif conjured_item?(item) && item.sell_in > 0
        item.sell_in -= 1
        item.quality -= 2 unless item.quality == 0
      elsif conjured_item?(item) && item.sell_in <= 0
        item.sell_in -= 1
        item.quality -= 4 unless item.quality == 0
      end
    end
  end

  private

  def not_a_special_item?(item)
    item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" && item.name != "Sulfuras, Hand of Ragnaros" && item.name != "Conjured item"
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured_item?(item)
    item.name == "Conjured item"
  end

  def aged_brie_quality_check(item)
    if item.sell_in >= 0
      item.quality += 1
    else
      item.quality += 2
    end
  end

  def passes_sell_in_check(item)
    if item.sell_in <= 0
      item.quality = 0
    elsif item.sell_in <= 5 && item.quality < 50
      item.quality += 3
    elsif item.sell_in <= 10 && item.quality < 50
      item.quality += 2
    elsif item.sell_in > 10 && item.quality < 49
      item.quality += 1
    end
  end

  def is_quality_fifty?(item)
    item.quality == 50
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
