package Processors.Game.Lobby.Exercise.SeptemberActive.Compoents
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.SeptemberActive.TSeptemberActive2;
   import Logics.Exercise.TBaseActivity;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.SeptemberActive.TProcessorSeptemberActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TUISeptemberActive2 extends TUIBaseWindow
   {
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const WATER_REWARD_COUNT:int = 8;
      
      protected static const FRUIT_COUNT:int = 10;
      
      public static const MOVIE_TYPE_WATER:int = 1;
      
      public static const MOVIE_TYPE_TREE:int = 2;
      
      protected var FSeptemberActive2:TSeptemberActive2;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FWaterReward:TUIShowItem;
      
      protected var FFruitList:TUIShowItem;
      
      protected var FTF_CDTime:TextField;
      
      protected var FIsCD:Boolean;
      
      public function TUISeptemberActive2(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         this.FWaterReward = new TUIShowItem(this,WATER_REWARD_COUNT);
         this.FWaterReward.Perform_UIDispatch(FMC_Scene.MC_WaterReward);
         this.FWaterReward.OnOverlay = this.ProcessorOnItemOver;
         this.FWaterReward.OnOut = this.ProcessorOnItemOut;
         this.FFruitList = new TUIShowItem(this,FRUIT_COUNT);
         this.FFruitList.Perform_UIDispatch(FMC_Scene.MC_Fruits);
         this.FFruitList.OnOverlay = this.ProcessorOnItemOver;
         this.FFruitList.OnOut = this.ProcessorOnItemOut;
         FMC_Scene.MC_Movie.visible = false;
         FMC_Scene.MC_End.visible = false;
         this.FTF_CDTime = FMC_Scene.TF_Time;
         this.ResourcesPerform_UILocations();
      }
      
      protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Water,true);
         FMC_Scene.BTN_Water.addEventListener(MouseEvent.CLICK,this.ProcessorOnWaterUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_GotoRecharge,true);
         FMC_Scene.BTN_GotoRecharge.addEventListener(MouseEvent.CLICK,ProcessorOnGotoRecharge);
         _loc1_ = 0;
         while(_loc1_ < FRUIT_COUNT)
         {
            FMC_Scene.MC_Fruits["MC_Slot" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnFruitUp);
            _loc1_++;
         }
      }
      
      protected function UpdateShowItem() : void
      {
         this.FShowItem.UpdateUI(this.FSeptemberActive2.ShowItems);
      }
      
      protected function UpdateWaterReward() : void
      {
         this.FWaterReward.UpdateUI(this.FSeptemberActive2.WaterReward);
      }
      
      protected function UpdateFruitList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FFruitList.UpdateUI(this.FSeptemberActive2.FruitList);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Water,this.FIsCD);
         _loc1_ = 0;
         while(_loc1_ < FRUIT_COUNT)
         {
            if(_loc1_ < this.FSeptemberActive2.FruitStatus.length)
            {
               _loc2_ = FMC_Scene.MC_Fruits["MC_Slot" + _loc1_];
               if(this.FIsCD)
               {
                  _loc2_.MC_Got.visible = false;
                  _loc2_.MC_Click.visible = false;
               }
               else if(this.FSeptemberActive2.FruitStatus[_loc1_] == TBaseActivity.STATUS_GETED)
               {
                  _loc2_.MC_Got.visible = true;
                  _loc2_.MC_Click.visible = false;
               }
               else
               {
                  _loc2_.MC_Got.visible = false;
                  _loc2_.MC_Click.visible = true;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTree() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(this.FSeptemberActive2.TreeLevel == -1)
         {
            FMC_Scene.MC_Tree.gotoAndStop(2);
            FMC_Scene.MC_End.visible = true;
            FMC_Scene.TF_Level.text = this.FSeptemberActive2.DescListNew[3];
         }
         else
         {
            FMC_Scene.MC_Tree.gotoAndStop(1);
            FMC_Scene.MC_End.visible = false;
            FMC_Scene.TF_Level.text = "LV" + this.FSeptemberActive2.TreeLevel;
         }
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FSeptemberActive2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FSeptemberActive2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FSeptemberActive2.DescListNew[1];
         FMC_Scene.TF_Price.text = this.FSeptemberActive2.MaxGold.toString();
         FMC_Scene.TF_WaterCount.text = this.FSeptemberActive2.WaterCount.toString();
         FMC_Scene.TF_RechargeGold.text = this.FSeptemberActive2.CurGold + "/" + this.FSeptemberActive2.MaxGold;
      }
      
      protected function ProcessorOnWaterUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(FOnGetBox != null) && Boolean(this.FSeptemberActive2) && this.FSeptemberActive2.TreeLevel != TBaseActivity.STATUS_GETED)
         {
            if(this.FSeptemberActive2.WaterCount > 0)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorSeptemberActive.ACTIVITY_2_WATER_UP);
            }
            else
            {
               FOnBuyBox(ACTIVITY_2_ID,TProcessorSeptemberActive.ACTIVITY_2_WATER_UP,this.FSeptemberActive2.WaterPrice);
            }
         }
      }
      
      protected function ProcessorOnFruitUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         if(Boolean(FOnGetBox != null && this.FSeptemberActive2 && _loc2_ < this.FSeptemberActive2.FruitStatus.length) && Boolean(this.FSeptemberActive2.FruitStatus[_loc2_] != TBaseActivity.STATUS_GETED) && !this.FIsCD)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorSeptemberActive.ACTIVITY_2_GET_FRUIT,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnItemOver(param1:Object, param2:Object) : void
      {
         if(FOnItemOver != null)
         {
            FOnItemOver(param1,param2);
         }
      }
      
      protected function ProcessorOnItemOut(param1:Object, param2:Object) : void
      {
         if(FOnItemOut != null)
         {
            FOnItemOut(param1,param2);
         }
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_2_ID);
         }
      }
      
      protected function ProcessorOnShowDesc(param1:MouseEvent) : void
      {
         if(FOnShowDesc != null)
         {
            FOnShowDesc();
         }
      }
      
      override public function Perform_UIDispatch(param1:MovieClip) : void
      {
         super.Perform_UIDispatch(param1);
      }
      
      override public function LogicsPerform() : void
      {
         var _loc1_:int = 0;
         if(FInitialized && this.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
            if(this.FWaterReward)
            {
               this.FWaterReward.LogicsPerform();
            }
            if(this.FFruitList)
            {
               this.FFruitList.LogicsPerform();
            }
            _loc1_ = this.FSeptemberActive2.NextTime - STimingCore.GetServerTick();
            this.FTF_CDTime.text = TGameUtil.FomatDayAndTime(_loc1_);
            if(_loc1_ <= 0 && this.FIsCD || _loc1_ > 0 && !this.FIsCD)
            {
               this.FIsCD = _loc1_ <= 0 ? false : true;
               this.FSeptemberActive2.ChangeStatus();
               this.UpdateFruitList();
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FSeptemberActive2 = SLogicsCore.SeptemberActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TSeptemberActive2;
         this.UpdateShowItem();
         this.UpdateWaterReward();
         this.UpdateFruitList();
         this.UpdateTree();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         switch(param1)
         {
            case MOVIE_TYPE_WATER:
               FMC_Scene.MC_Effect.gotoAndPlay(1);
               break;
            case MOVIE_TYPE_TREE:
               FMC_Scene.MC_Movie.visible = true;
               FMC_Scene.MC_Movie.gotoAndPlay(1);
         }
      }
   }
}

