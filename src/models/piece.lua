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

function Piece.new()
    return {
        shape = Piece.TETROMINOES[love.math.random(#Piece.TETROMINOES)],
        x = 0,
        y = 1
    }
end

return Piece