platforms = {
  "Playstation 5": 1,
  "Xbox Series X": 2,
  "Nintendo Switch": 3,
  PC: 4,
  "Xbox 360": 5,
  "PlayStation 3": 6,
  "Xbox One": 7,
  "PlayStation 4": 8,
};

async function getResults() {
  const response = await fetch(
    "https://www.speedrun.com/api/v1/runs?max=200&game=om1mx362"
  );
  const data = await response.json();
  for (let i = 0; i < 200; i++) {
    let platform = await fetch(
      `https://www.speedrun.com/api/v1/platforms/${data.data[i].system.platform}`
    );
    platform = await platform.json();
    if (
      data.data[i].submitted !== null &&
      platforms[platform.data.name] !== undefined
    ) {
      // console.log(data.data[i].status.status == "verified" ? 1 : 0);
      console.log(
        `(${Math.round(Math.random() * 3 + 1)}, 1, 1, ${
          platforms[platform.data.name]
        }, 1, ${data.data[i].times.primary_t}, ${
          data.data[i].times.ingame_t
        }, 1.64, '${data.data[i].submitted}', '${
          data.data[i].videos.links[0].uri
        }', ${data.data[i].status.status == "verified" ? 1 : 0}),`
      );
    }
  }
}

getResults();
