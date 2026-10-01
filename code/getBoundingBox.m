function bb = getBoundingBox(S)

bb = [
    min(S.V,[],1);
    max(S.V,[],1); 
        ];

end