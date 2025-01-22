local RandomBag = require('src.utils.random_bag')
local Piece = {}

Piece.TETROMINOES = {
    -- I piece
    {
        {
            {0, 0, 0, 0},
            {1, 1, 1, 1},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        color = {0, 1, 1} -- cyan
    },
    -- O piece
    {
        {
            {1, 1},
            {1, 1}
        },
        color = {1, 1, 0} -- yellow
    },
    -- T piece
    {
        {
            {0, 1, 0},
            {1, 1, 1},
            {0, 0, 0}
        },
        color = {1, 0, 1} -- purple
    },
    -- L piece
    {
        {
            {0, 0, 1},
            {1, 1, 1},
            {0, 0, 0}
        },
        color = {1, 0.5, 0} -- orange
    },
    -- J piece
    {
        {
            {1, 0, 0},
            {1, 1, 1},
            {0, 0, 0}
        },
        color = {0, 0, 1} -- blue
    },
    -- S piece
    {
        {
            {0, 1, 1},
            {1, 1, 0},
            {0, 0, 0}
        },
        color = {0, 1, 0} -- green
    },
    -- Z piece
    {
        {
            {1, 1, 0},
            {0, 1, 1},
            {0, 0, 0}
        },
        color = {1, 0, 0} -- red
    }
}

function Piece.rotate(pieceData)
    local oldPiece = pieceData.shape[1]
    local newPiece = {}
    
    for y = 1, #oldPiece[1] do
        newPiece[y] = {}
        for x = 1, #oldPiece do
            newPiece[y][x] = oldPiece[#oldPiece - x + 1][y]
        end
    end
    
    return newPiece
end

local pieceBag = RandomBag.new(7) -- 7 for the number of tetromino types
function Piece.new()
    local pieceIndex = pieceBag:next()
    return {
        shape = Piece.TETROMINOES[pieceIndex],
        x = 0,
        y = 1
    }
end

function Piece.resetBag()
    pieceBag:initBags()
end
return Piece