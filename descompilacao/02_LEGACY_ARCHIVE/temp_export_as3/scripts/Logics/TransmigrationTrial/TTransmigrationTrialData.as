package Logics.TransmigrationTrial
{
   import flash.utils.Dictionary;
   
   public class TTransmigrationTrialData
   {
      
      protected var FTrialCampaignList:Vector.<TTrialCampaign>;
      
      protected var FScoreList:Dictionary;
      
      public function TTransmigrationTrialData()
      {
         super();
         this.FTrialCampaignList = new Vector.<TTrialCampaign>();
         this.FScoreList = new Dictionary();
         this.FScoreList["32"] = 0;
         this.FScoreList["33"] = 0;
         this.FScoreList["36"] = 0;
      }
      
      public function get TrialCampaignList() : Vector.<TTrialCampaign>
      {
         return this.FTrialCampaignList;
      }
      
      public function get ScoreList() : Dictionary
      {
         return this.FScoreList;
      }
      
      public function AddTrialCampaign(param1:TTrialCampaign) : void
      {
         this.FTrialCampaignList.push(param1);
      }
      
      public function GetTrialCampaignByCampaignId(param1:uint) : TTrialCampaign
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc4_:TTrialCampaign = null;
         _loc2_ = 0;
         while(_loc2_ < this.FTrialCampaignList.length)
         {
            _loc4_ = this.FTrialCampaignList[_loc2_];
            if(_loc4_.CampaignId == param1)
            {
               return _loc4_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function GetScoreByReincarnatonLevel(param1:uint) : uint
      {
         return this.FScoreList[param1];
      }
      
      public function IsAttacked() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:uint = 0;
         var _loc3_:TTrialCampaign = null;
         var _loc4_:Boolean = false;
         _loc4_ = false;
         _loc1_ = 0;
         while(_loc1_ < this.FTrialCampaignList.length)
         {
            _loc3_ = this.FTrialCampaignList[_loc1_];
            if(_loc3_.CurStageId != 0)
            {
               _loc4_ = true;
               break;
            }
            _loc1_++;
         }
         return _loc4_;
      }
   }
}

