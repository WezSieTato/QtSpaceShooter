.pragma library
.import QtQuick 2.0 as QQ

var game;
var ship;
var asteroidClock = 0

Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

function update() {
    var toDestroy = new Array();
    game.friendlyMissiles.forEach(function(missile){
        missile.x += 5
        if (missile.x > game.width)
            toDestroy.push(missile);

    })

    game.asteroids.forEach(function(asteroid){
        asteroid.x -= 2
        if(asteroid.x + asteroid.width < 0){
            toDestroy.push(asteroid)
        } else {
            game.friendlyMissiles.forEach(function(missile){
                if(isCollide(missile,asteroid)){
                    toDestroy.push(missile);
                    toDestroy.push(asteroid);
                } else if (isCollide(ship, asteroid)){
                    console.log("defet");
                }

            })
        }
    });


    var len = toDestroy.length
    for(var i = 0; i < len; ++i){
        var victim = toDestroy.pop();
        var index = game.friendlyMissiles.indexOf(victim);
        if(index >= 0){
            game.friendlyMissiles.splice(index, 1);
        }

        index = game.asteroids.indexOf(victim);
        if(index >= 0){
            game.asteroids.splice(index, 1);
        }

        victim.destroy();

        console.log("usuwam ilosc laserow" + game.asteroids.length )
    }

    if(asteroidClock > 0){
        asteroidClock--;
    } else {
        asteroidClock = 60;
        game.createAsteroid();
    }

}


function isCollide(itemA, itemB){
    return !(   itemA.x + itemA.width < itemB.x  ||
                itemB.x + itemB.width < itemA.x  ||
                 itemA.y + itemA.height < itemB.y  ||
                 itemB.y + itemB.height < itemA.y)
}
