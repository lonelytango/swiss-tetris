local RandomBag = require('src.utils.random_bag')
local Theme = require('src.themes.theme')
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
        type = 'I'
    },
    -- O piece
    {
        {
            {1, 1},
            {1, 1}
        },
        type = 'O'
    },
    -- T piece
    {
        {
            {0, 1, 0},
            {1, 1, 1},
            {0, 0, 0}
        },
        type = 'T'
    },
    -- L piece
    {
        {
            {0, 0, 1},
            {1, 1, 1},
            {0, 0, 0}
        },
        type = 'L'
    },
    -- J piece
    {
        {
            {1, 0, 0},
            {1, 1, 1},
            {0, 0, 0}
        },
        type = 'J'
    },
    -- S piece
    {
        {
            {0, 1, 1},
            {1, 1, 0},
            {0, 0, 0}
        },
        type = 'S'
    },
    -- Z piece
    {
        {
            {1, 1, 0},
            {0, 1, 1},
            {0, 0, 0}
        },
        type = 'Z'
    },
    -- -- A piece
    -- {
    --     {
    --         { 1 }
    --     },
    --     type = 'A'
    -- },
    -- -- B piece
    -- {
    --     {
    --         { 1, 1 },
    --         { 0, 0 }
    --     },
    --     type = 'B'
    -- },
    -- -- C piece
    -- {
    --     {
    --         { 1, 0 },
    --         { 1, 1 }
    --     },
    --     type = 'C'
    -- }
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

local pieceBag = RandomBag.new(#Piece.TETROMINOES) -- 7 for the number of tetromino types
function Piece.new()
    local pieceIndex = pieceBag:next()
    local piece = {
        shape = Piece.TETROMINOES[pieceIndex],
        x = 0,
        y = 1
    }
    piece.color = Theme.getPieceColor(piece.shape.type)
    return piece
end

function Piece.resetBag()
    pieceBag:initBags()
end
return Piece