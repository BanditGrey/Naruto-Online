package Logics.MasterRoad
{
   import Logics.DatebaseVO.VO.TMasterRoadMall;
   import Logics.DatebaseVO.VO.TMasterRoadVenue;
   import Logics.Exercise.ConsumeRank.TConsumeRankInfo;
   
   public class TMasterRoad
   {
      
      public var IsFirst:int;
      
      public var MyScore:int;
      
      public var TempleIndex:int;
      
      public var TempleStatus:int;
      
      public var Manifesto:String;
      
      public var VenuesData:Vector.<TMasterRoadVenue>;
      
      public var HonorPlayers:Vector.<TConsumeRankInfo>;
      
      public var MallData:Vector.<TMasterRoadMall>;
      
      public function TMasterRoad()
      {
         super();
         this.Manifesto = "";
         this.VenuesData = new Vector.<TMasterRoadVenue>();
         this.HonorPlayers = new Vector.<TConsumeRankInfo>();
         this.MallData = new Vector.<TMasterRoadMall>();
      }
      
      public function GetVenueByIdentify(param1:int) : TMasterRoadVenue
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.VenuesData.length)
         {
            if(this.VenuesData[_loc2_].Identifier == param1)
            {
               return this.VenuesData[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetVenuePointByIdentify(param1:int) : int
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.VenuesData.length)
         {
            if(this.VenuesData[_loc2_].Identifier == param1)
            {
               return this.VenuesData[_loc2_].CurPoint;
            }
            _loc2_++;
         }
         return 0;
      }
      
      public function GetMallByIdentify(param1:int) : TMasterRoadMall
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.MallData.length)
         {
            if(this.MallData[_loc2_].Identifier == param1)
            {
               return this.MallData[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
   }
}

