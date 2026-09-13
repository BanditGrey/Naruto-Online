package Logics.NinjaRelation
{
   public class TNinjaTeamBuff
   {
      
      protected var FGourpID:uint;
      
      protected var FTeamName:String;
      
      protected var FTeamIDs:Vector.<uint>;
      
      protected var FBuffValue:Vector.<String>;
      
      public function TNinjaTeamBuff()
      {
         super();
         this.FGourpID = 0;
         this.FTeamName = "";
         this.FTeamIDs = new Vector.<uint>();
         this.FBuffValue = new Vector.<String>();
      }
      
      public function get GourpID() : uint
      {
         return this.FGourpID;
      }
      
      public function set GourpID(param1:uint) : void
      {
         this.FGourpID = param1;
      }
      
      public function get TeamIDs() : Vector.<uint>
      {
         return this.FTeamIDs;
      }
      
      public function set TeamIDs(param1:Vector.<uint>) : void
      {
         this.FTeamIDs = param1;
      }
      
      public function get BuffValue() : Vector.<String>
      {
         return this.FBuffValue;
      }
      
      public function set BuffValue(param1:Vector.<String>) : void
      {
         this.FBuffValue = param1;
      }
      
      public function get TeamName() : String
      {
         return this.FTeamName;
      }
      
      public function set TeamName(param1:String) : void
      {
         this.FTeamName = param1;
      }
   }
}

