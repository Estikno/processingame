SoundFile rebote;
SoundFile victoria;
SoundFile death;
SoundFile musica;

String reboteSound = "col.mp3";
String deathSound = "death.mp3";
String victoriaSound = "victoria.mp3";

void audio(String name){
  if(name == victoriaSound) victoria.play();
  if(name == reboteSound && !rebote.isPlaying()) rebote.play();
  if(name == deathSound) death.play();
}
