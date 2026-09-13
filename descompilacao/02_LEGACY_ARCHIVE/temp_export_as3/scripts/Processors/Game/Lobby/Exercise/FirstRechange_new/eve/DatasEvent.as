package Processors.Game.Lobby.Exercise.FirstRechange_new.eve
{
   import flash.events.Event;
   
   public class DatasEvent extends Event
   {
      
      public var data:*;
      
      public function DatasEvent(param1:String, param2:* = null)
      {
         super(param1);
         this.data = param2;
      }
   }
}

