
require 'sinatra'
class AirQualityApp < Sinatra::Base
  suggestions_list=["Conserve energy – remember to turn off lights, computers, and electric appliances when not in use.",
  "Use energy efficient light bulbs and appliances.",
  "Participate in your local utility’s energy conservation programs.",
  "Limit driving by carpooling, using public transportation, biking and walking.",
  "Combine errands for fewer trips.",
  "Keep your automobile well tuned and maintained. Follow the manufacturer’s instructions on routine maintenance, such as changing the oil and filters, and checking tire pressure and wheel alignment.",
  "Avoid excessive idling of your automobile.",
  "Use electric or hand-powered lawn care equipment.",
  "Be careful not to spill gasoline when filling up your car or gasoline powered lawn and garden equipment.",
  "Run dishwashers and clothes washers only when full.",
  "Choose environmentally friendly cleaners.",
  "Use water-based or solvent free paints whenever possible and buy products that say low VOC.",
  "Seal containers of household cleaners, workshop chemicals and solvents, and garden chemicals to prevent volatile organic compounds from evaporating into the air.",
  "Purchase and use low-polluting outboard marine engines and personal watercraft (4-stroke and direct fuel injection 2-stroke outboard marine engines).",
  "Advocate for emission reductions from power plants and more stringent national vehicle emission standards."]




    set :views, "views"
    set :public_folder, 'public'

    get '/' do
        co = params['co'].to_i
        no2 = params['no2'].to_i
        o3 = params['o3'].to_i
        ppm = params['ppm'].to_i

        results = ""

        co_val = co_level(co)

        results+= "CO Level is DANGEROUS.\n " if co_val == 1
        results+= "CO Level is UNSAFE.\n" if co_val == 0
        results+= "CO Level is SAFE.\n" if co_val == -1

        no2_val = no2_level(no2)
        results+= "NO2 Level is DANGEROUS. \n" if no2_val == 1
        results+= "NO2 Level is UNSAFE.\n" if no2_val == 0
        results+= "NO2 Level is SAFE.\n" if no2_val == -1

        o3_val = o3_level(o3)
        results+= "O3 Level is DANGEROUS.\n " if o3_val == 1
        results+= "O3 Level is UNSAFE.\n " if o3_val == 0
        results+= "O3 Level is SAFE.\n  " if o3_val == -1

        ppm_val = ppm_level(ppm)

        results+= "Particulate matter Level is DANGEROUS. \n" if ppm_val == 1

        results+= "Particulate matter Level is UNSAFE.\n " if ppm_val == 0

        results+= "Particulate matter Level is SAFE.\n" if ppm_val == -1

        results+=suggestions_list.sample

        return results



    end


    def co_level(co)
      return 1 if co >= 10
      return 0 if co < 10 and co > 6
      return -1 if co < 6
    end

    def no2_level(no2)
      return 1 if no2 >= 200
      return 0 if no2 < 200 and no2 > 140
      return -1 if no2 < 140
    end

    def o3_level(o3)
      return 1 if o3 >= 120
      return 0 if o3 < 120 and o3 > 72
      return -1 if o3 < 72
    end


    def ppm_level(ppm)
      return 1 if ppm >= 25
      return 0 if ppm < 25 and ppm > 16
      return -1 if ppm < 16
    end




end

AirQualityApp.run!
