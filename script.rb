#!/usr/bin/env ruby

require('csv')

@categories = {
  "IT" => [
    "SQUARESPACE",
    "DIGITALOCEAN.COM",
    "DRI*Adobe",
    "GITHUB.COM",
    "Amazon web services",
    "ITUNES.COM/BILL",
    "GOOGLE *SVCSAPPS_SINGJ",
    "DROPBOX",
    "PAPERTRAIL",
    "HEROKU",
  ],
  "FOOD" => [
    "BOON TONG KEE",
    "SUBWAY",
    "THE DAILY",
    "IMPERIAL TREASURE",
    "KIAN SENG",
    "COCO ICHIBANYA",
    "IKEA-RESTAURANT",
    "SUSHI EXPRESS",
    "WHITE BEEHOON",
    "XIN WANG",
    "ITACHO",
    "WEE NAM KEE",
    "RONG HUA BAK KUT TEH",
    "ZAKKA",
    "HK KIM GARY",
    "TCC",
    "YAYOI",
    "SAKAE",
    "DIN TAI FUNG",
    "MCDONALD",
    "PIZZA HUT",
    "8 KOREAN BBQ",
    "SUSHI-TEI",
    "SWENSEN'S",
    "KURIYA",
    "TIM HO WAN",
    "DEMPSEY BARRACKS",
    "2D1N",
    "SHANGRI-LA HOTEL",
    "TOAST BOX",
    "FRUIT PARADISE",
    "ICHIBAN",
    "TONKICHI",
    "DELIFRANCE",
    "ARKADAS CAFE",
    "BUCKTILE",
    "HORKOMO",
  ],
  "DESSERT" => [
    "LADY M",
    "GARRETT POPCORN",
    "BEE CHENG HIANG",
    "THE COFFEE BEAN",
    "STARBUCKS",
  ],
  "BABY_MEDICAL" => ["KINDER CLINIC", "HEALTHCARE", "NHG"],
  "BABY" => ["KIDDY PALACE", "MOTHERCARE", "BABY KINGDOM", "BEAUTY.MUMS & BABIES", "PETIT BATEAU", "TOYS'R'US", "GAPKIDS", "MUMS & BABES", "BB SPA", "BLOOMB"],
  "BOOKS" => ["AMAZON SERVICES-KINDLE", "Kindle Unlimited"],
  "ECOMMERCE" => ["Shopee"],
  "MOVIES" => ["SHAW"],
  "BILLS" => ["STARHUB", "M1"],
  "INSURANCE" => ["AIA INSURANCE"],
  "PETROL" => ["SPC"],
  "HOME" => ["IKEA", "BEDROOM AFFAIR"],
  "CAR" => ["DIRECT ASIA", "LAND TRANSPORT AUTH", "HDB SEASON PARKING", "HOUSING & DEVELOPMENT", "EZ-LINK"],
  "GROCERIES" => ["FAIRPRICE", "RedMart", "SHENG SIONG", "COLD STORAGE"],
  "FASHION" => ["COTTON ON", "UNIQLO", "H&M", "G2000"],
  "MISC" => ["POPULAR", "GUARDIAN"],
}

def pretty_print_amount amount
  sprintf("$%.2f", amount)
end

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end
def blue(text); colorize(text, 34); end

def format file
  results = []
  CSV.foreach(file) do |row|
    date = row[0]
    name = row[1]
    amount = row[2].to_f * -1

    next if name.start_with?("MONEYSEND Card")
    next if name.start_with?("Card Bill Payment")

    results << {:date => date, :name => name, :amount => amount}
  end

  results
end

def group_by_month entries
  grouped = {}
  entries.each do |entry|
    month_year_key = entry[:date].slice(-7..-1)
    if grouped[month_year_key].nil?
      grouped[month_year_key] = []
    end

    grouped[month_year_key] << entry
  end

  grouped
end

def analyze_and_print months
  sorted_months = months.map { |k,v| k}.sort_by { |e| e}
  sorted_months.each do |month|
    entries = months[month]
    total_per_month = 0

    categories = {}

    entries.each do |entry|
      name = entry[:name]

      found = false
      @categories.each do |category, phrases|
        categories[category] = [] if categories[category].nil?

        phrases.each do |phrase|
          if name.downcase.start_with?(phrase.downcase)

            categories[category] << entry
            found = true
            break
          end
        end

        break if found
      end

      unless found
        categories["MISC"] << entry
      end

      total_per_month += entry[:amount]
    end

    puts "================================================"
    puts "Month: #{blue(month)}:"
    puts "================================================"

    @categories.each do |category, phrases|
      entries = categories[category] || []

      total_per_category = 0

      entries.each do |entry|
        total_per_category += entry[:amount]
      end

      puts "[#{green(category)}]: #{red(pretty_print_amount(total_per_category))}"

      entries.each do |entry|
        puts "--- #{entry[:name]} - #{pretty_print_amount(entry[:amount])}"
      end
    end

    puts "Total: #{red(pretty_print_amount(total_per_month))}"
  end
end

entries = []

unless ARGV.count > 0
  ARGF.each_with_index do |line, idx|
    entries += (format(File.join(Dir.pwd, line.strip)))
  end
end

ARGV.each do |arg|
  entries += (format(arg))
end

grouped = group_by_month(entries)

analyze_and_print(grouped)
