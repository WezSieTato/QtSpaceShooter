.pragma library


function isCollide(itemA, itemB){
    return !(   itemA.x + itemA.width < itemB.x  ||
                itemB.x + itemB.width < itemA.x  ||
                 itemA.y + itemA.height < itemB.y  ||
                 itemB.y + itemB.height < itemA.y)
}

function randomFromInterval(from,to)
{
    return Math.floor(Math.random()*(to-from+1)+from);
}


