class MusicsController < ApplicationController
    
    def index
    end

    def search
        if params[:search1].present?
            @searchartists = RSpotify::Artist.search(params[:search])
        end
    end

    def input
        if (params[:input1].present?) && (params[:input2].present?) && (params[:input3].present?)
            @searchartist1 = RSpotify::Artist.search(params[:input1]).first
            @searchartist2 = RSpotify::Artist.search(params[:input2]).first
            @searchartist3 = RSpotify::Artist.search(params[:input3]).first

            #重複してるジャンルを取り出す
            duplicateGenre = [@searchartist1.genres, @searchartist2.genres, @searchartist3.genres].inject(&:&)
            
            #重複していないジャンルから合計5個になるようにランダムに取り出す
            genres = [@searchartist1.genres, @searchartist2.genres, @searchartist3.genres].flatten!
            counts = Hash.new(0)
            genres.each { |v| counts[v] += 1 }
            uniqueGenre = counts.select { |v, count| count == 1 }.keys

            @genres = duplicateGenre.push(uniqueGenre.sample(5 - duplicateGenre.length)).flatten!
            @recommendations = RSpotify::Recommendations.generate(seed_genres: @genres)
        end
    end
end