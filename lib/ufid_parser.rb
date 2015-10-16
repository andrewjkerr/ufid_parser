require "ufid_parser/version"

module UfidParser
    class UFID
        attr_accessor :ufid_number

        def initialize(str)
            @ufid_number = parse_ufid_number(str)
        end

        private

        def parse_ufid_number(str)
            # Barcode has two occurrances of UFID number separated by this string
            ufid_number_arr = str.split('02200')

            # Cut out the junk
            ufid_number_arr[0] = ufid_number_arr.first[4..-1]
            ufid_number_arr[-1] = ufid_number_arr.last[0..-5]

            # Check out requirement for UFID numbers
            if meet_ufid_number_requirements?(ufid_number_arr)
                return ufid_special_case(ufid_number_arr)
            end

            # Return the number!
            ufid_number_arr.first
        end

        def ufid_special_case(ufid_number_arr)
            # Return the one that has 
            if ufid_number_arr.first.size == ufid_number_arr.last.size
                raise Exception.new("Malformatted UFID input.")
            elsif ufid_number_arr.first.size == 8
                ufid_number_arr.first
            elsif ufid_number_arr.last.size == 8
                ufid_number_arr.last
            else
                raise Exception.new("Malformatted UFID input.")
            end
        end

        def meet_ufid_number_requirements?(ufid_number_arr)
            ufid_number_arr.first != ufid_number_arr.last || ufid_number_correct_size?(ufid_number_arr)
        end

        def ufid_number_correct_size?(ufid_number_arr)
            ufid_number_arr.first.size != 8 || ufid_number_arr.last.size != 8
        end
    end
end
