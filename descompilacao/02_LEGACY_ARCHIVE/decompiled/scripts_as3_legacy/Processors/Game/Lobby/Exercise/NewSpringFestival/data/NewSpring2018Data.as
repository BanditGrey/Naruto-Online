package Processors.Game.Lobby.Exercise.NewSpringFestival.data
{
   import Logics.Exercise.TBaseActivity;
   
   public class NewSpring2018Data extends TBaseActivity
   {
      
      public var actId:int;
      
      public var errorCode:int;
      
      public var beginTime:int;
      
      public var endTime:int;
      
      public var taskPoint:int;
      
      public var taskInfo:Array;
      
      public var boxFlag1:int;
      
      public var boxFlag2:int;
      
      public var totalRecharge:int;
      
      public var openNomalBagTimes:int;
      
      public var openSuperBagTimes:int;
      
      public var shopBuyTimes:Array;
      
      public var shopPoint:int;
      
      public var consumePoint:int;
      
      public var sale:int;
      
      public var Lantern1:Array;
      
      public var Lantern2:Array;
      
      public var Lantern3:Array;
      
      public var Lanterns:Array;
      
      public var giftBoxRewards:Array;
      
      public var giftBoxRewardsConfig:Array;
      
      public var bagRewardsPreviewConfig:Array;
      
      public var LanternRewardsPreviewConfig:Array;
      
      public function NewSpring2018Data()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         this.Lantern1 = [];
         this.Lantern2 = [];
         this.Lantern3 = [];
         this.Lanterns = [this.Lantern1,this.Lantern2,this.Lantern3];
         this.taskInfo = [];
         this.shopBuyTimes = [];
         this.giftBoxRewards = [];
         this.giftBoxRewardsConfig = [];
         this.bagRewardsPreviewConfig = [[],[]];
         this.LanternRewardsPreviewConfig = [];
      }
   }
}

