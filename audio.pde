SoundFile se;
SoundFile musica;

String reboteSound = "col.mp3";
String deathSound = "death.mp3";
String victoriaSound = "victoria.mp3";

void audio(String name){
  se = new SoundFile(this, name);
  se.play();
}
