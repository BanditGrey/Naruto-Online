package Logics.TransmigrationTrial
{
   public class TTrialCampaign
   {
      
      protected var FCampaignId:uint;
      
      protected var FCurStageId:uint;
      
      protected var FHistoryStageId:uint;
      
      protected var FTodayResetTimes:uint;
      
      public function TTrialCampaign()
      {
         super();
         this.FCampaignId = 0;
         this.FCurStageId = 0;
         this.FHistoryStageId = 0;
         this.FTodayResetTimes = 0;
      }
      
      public function get CampaignId() : uint
      {
         return this.FCampaignId;
      }
      
      public function set CampaignId(param1:uint) : void
      {
         this.FCampaignId = param1;
      }
      
      public function get CurStageId() : uint
      {
         return this.FCurStageId;
      }
      
      public function set CurStageId(param1:uint) : void
      {
         this.FCurStageId = param1;
         this.FHistoryStageId = Math.max(this.FCurStageId,this.FHistoryStageId);
      }
      
      public function get HistoryStageId() : uint
      {
         return this.FHistoryStageId;
      }
      
      public function set HistoryStageId(param1:uint) : void
      {
         this.FHistoryStageId = param1;
      }
      
      public function get TodayResetTimes() : uint
      {
         return this.FTodayResetTimes;
      }
      
      public function set TodayResetTimes(param1:uint) : void
      {
         this.FTodayResetTimes = param1;
      }
   }
}

