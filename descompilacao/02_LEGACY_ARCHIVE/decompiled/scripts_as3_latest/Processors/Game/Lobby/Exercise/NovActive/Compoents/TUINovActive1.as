package Processors.Game.Lobby.Exercise.NovActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Exercise.DessertHouse.TDessertHouseTask;
   import Logics.Exercise.NovActive.TNovActive1;
   import Logics.Exercise.TActivityTaskData;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIShowItem;
   import Processors.Game.Lobby.Exercise.NovActive.TProcessorNovActive;
   import Processors.Game.Lobby.Exercise.NovActive.TProcessorNovActiveShop;
   import Resources.Constants.CONST_BASEACTIVITY;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.Expo;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUINovActive1 extends TUIBaseWindow
   {
      
      protected static const BOX_COUNT:int = 5;
      
      protected static const TASK_STEP:int = TActivityTaskData.STEP_COUNT;
      
      protected static const TASK_COUNT:int = 5;
      
      protected static const SHOW_ITEM_COUNT:int = 4;
      
      protected static const LABA_COUNT:int = 6;
      
      protected static const LABA_ItemStamp:int = 66;
      
      protected static const MAX_LABACOUNT:int = 4;
      
      protected static const ACTIVITY_1_ID:int = 1;
      
      protected static const MOVIE_TYPE_SINGLE:int = 1;
      
      protected static const MOVIE_TYPE_TEN:int = 2;
      
      protected var FNovActive1:TNovActive1;
      
      protected var FActivityTaskData:TActivityTaskData;
      
      protected var FUIItems:Vector.<MovieClip>;
      
      protected var FLabaList0:MovieClip;
      
      protected var FLabaList1:MovieClip;
      
      protected var FLabaList2:MovieClip;
      
      protected var FShowItem:TUIShowItem;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FLabaInitY:int;
      
      protected var FLabaIndex0:int;
      
      protected var FLabaIndex1:int;
      
      protected var FLabaIndex2:int;
      
      protected var FUINovActiveAutoLog:TUINovActiveAutoLog;
      
      protected var FProcessorNovActiveShop:TProcessorNovActiveShop;
      
      protected var FIsFirst:Boolean;
      
      public function TUINovActive1(param1:TUIComponent)
      {
         super(param1);
         this.FActivityTaskData = SLogicsCore.ActivityTaskData;
         this.FUIItems = new Vector.<MovieClip>(LABA_COUNT);
         this.FUIPage = new TUIPage(this);
         this.FIsFirst = true;
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < LABA_COUNT)
         {
            _loc5_ = TUtilityReflection.CreateDisplayObjectInstance("MC_NovActiveItem") as MovieClip;
            this.FUIItems[_loc2_] = _loc5_;
            _loc2_++;
         }
         this.FLabaList0 = FMC_Scene.MC_Laba["MC_LabaItem0"];
         this.FLabaList0.addChild(this.FUIItems[0]);
         this.FLabaList0.addChild(this.FUIItems[1]);
         this.FLabaList1 = FMC_Scene.MC_Laba["MC_LabaItem1"];
         this.FLabaList1.addChild(this.FUIItems[2]);
         this.FLabaList1.addChild(this.FUIItems[3]);
         this.FLabaList2 = FMC_Scene.MC_Laba["MC_LabaItem2"];
         this.FLabaList2.addChild(this.FUIItems[4]);
         this.FLabaList2.addChild(this.FUIItems[5]);
         this.FLabaInitY = this.FLabaList0.y;
         _loc2_ = 0;
         while(_loc2_ < TASK_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Task" + _loc2_];
            _loc4_.MC_Reward.gotoAndStop(_loc2_ + 1);
            TGameUtil.setButtonMode(_loc4_.BTN_Go,true);
            _loc4_.BTN_Go.addEventListener(MouseEvent.CLICK,this.ProcessorOnGoUp);
            TGameUtil.setButtonMode(_loc4_.BTN_GetTask,true);
            _loc4_.BTN_GetTask.addEventListener(MouseEvent.CLICK,this.ProcessorOnGetTaskUp);
            TGameUtil.setButtonMode(_loc4_.BTN_Finish,true);
            _loc4_.BTN_Finish.addEventListener(MouseEvent.CLICK,this.ProcessorOnFinishUp);
            _loc4_.MC_Reward.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnRewardOver);
            _loc4_.MC_Reward.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.MC_Server.BTN_Get,true);
         FMC_Scene.MC_Server.MC_GoldPic.addEventListener(MouseEvent.CLICK,this.ProcessorOnServerListUp);
         FMC_Scene.MC_Server.MC_GoldPic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnServerListOver);
         FMC_Scene.MC_Server.MC_GoldPic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         this.FShowItem = new TUIShowItem(this,SHOW_ITEM_COUNT);
         this.FShowItem.Perform_UIDispatch(FMC_Scene.MC_ShowItem);
         this.FShowItem.OnOverlay = this.ProcessorOnItemOver;
         this.FShowItem.OnOut = this.ProcessorOnItemOut;
         this.FShowItem.OnShowRecruit = this.ProcessorOnShowRecruit;
         TGameUtil.setButtonMode(FMC_Scene.BTN_Buy,true);
         FMC_Scene.BTN_Buy.addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Ten,true);
         FMC_Scene.BTN_Ten.addEventListener(MouseEvent.CLICK,this.ProcessorOnTenUp);
         FMC_Scene.BTN_Ten.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnTenOver);
         FMC_Scene.BTN_Ten.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeUp);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Rank,true);
         FMC_Scene.BTN_Rank.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadRank);
         this.FUINovActiveAutoLog = new TUINovActiveAutoLog(this.Parent.Parent);
         this.FUINovActiveAutoLog.Visible = false;
         this.FUINovActiveAutoLog.OnCloseUp = this.ProcessorOnCloseAutoLog;
         this.FProcessorNovActiveShop = new TProcessorNovActiveShop(this.Parent);
         this.FProcessorNovActiveShop.Visible = false;
         this.FProcessorNovActiveShop.OnCloseUp = this.ProcessorOnCloseShop;
         this.FProcessorNovActiveShop.OnOverlay = this.ProcessorOnItemOver;
         this.FProcessorNovActiveShop.OnOut = this.ProcessorOnItemOut;
         this.FProcessorNovActiveShop.OnGetBox = this.ProcessorOnGetReward;
         this.FProcessorNovActiveShop.OnExchange = this.ProcessorOnExchangeItem;
         this.FProcessorNovActiveShop.X = -18;
         this.FProcessorNovActiveShop.y = -27;
      }
      
      protected function UpdateTask() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TDessertHouseTask = null;
         _loc1_ = 0;
         while(_loc1_ < TASK_COUNT)
         {
            _loc4_ = FMC_Scene["MC_Task" + _loc1_];
            if(_loc1_ < this.FActivityTaskData.TaskList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FActivityTaskData.TaskList[_loc1_];
               _loc3_ = _loc5_.Step >= TASK_STEP ? int(TASK_STEP - 1) : _loc5_.Step;
               _loc4_.TF_Desc.text = TUtilityString.Format(_loc5_.TaskDesc,_loc5_.TaskReq[_loc3_]);
               _loc4_.TF_Process.text = _loc5_.Process + "/" + _loc5_.ClientTaskReq[_loc3_];
               if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.BTN_Finish.visible = false;
                  _loc4_.BTN_GetTask.visible = true;
                  _loc4_.MC_Finish.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.BTN_Finish.visible = true;
                  _loc4_.BTN_GetTask.visible = false;
                  _loc4_.MC_Finish.visible = false;
                  if(_loc5_.Process >= _loc5_.ClientTaskReq[_loc3_])
                  {
                     TGameUtil.setButtonMode(_loc4_.BTN_Finish,true);
                  }
                  else
                  {
                     TGameUtil.setButtonMode(_loc4_.BTN_Finish,false);
                  }
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc4_.BTN_Finish.visible = false;
                  _loc4_.BTN_GetTask.visible = false;
                  _loc4_.MC_Finish.visible = true;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateServerList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TBaseBox = null;
         var _loc4_:TBaseBox = null;
         _loc2_ = FMC_Scene.MC_Server;
         _loc3_ = this.FNovActive1.ServerList;
         _loc2_.TF_Price.text = TUtilityString.Format(this.FNovActive1.DescListNew[3],_loc3_.Price);
         if(_loc3_.Count > 0)
         {
            _loc2_.MC_Click.visible = true;
         }
         else
         {
            _loc2_.MC_Click.visible = false;
         }
      }
      
      protected function UpdateShowItem() : void
      {
         this.FShowItem.UpdateUI(this.FNovActive1.ShowItems);
      }
      
      protected function UpdateLaBa() : void
      {
         var _loc1_:uint = 0;
         this.FLabaList0.y = this.FLabaInitY;
         this.FLabaList1.y = this.FLabaInitY;
         this.FLabaList2.y = this.FLabaInitY;
         _loc1_ = 0;
         while(_loc1_ < LABA_COUNT)
         {
            if(_loc1_ % 2 == 0)
            {
               this.FUIItems[_loc1_].y = 0;
               this.FUIItems[_loc1_].MC_Icon.gotoAndStop(1);
            }
            else
            {
               this.FUIItems[_loc1_].y = LABA_ItemStamp;
               this.FUIItems[_loc1_].MC_Icon.gotoAndStop(2);
            }
            _loc1_++;
         }
         this.FLabaIndex0 = 1;
         this.FLabaIndex1 = 1;
         this.FLabaIndex2 = 1;
      }
      
      protected function UpdateText() : void
      {
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FNovActive1.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FNovActive1.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FNovActive1.DescListNew[1];
         FMC_Scene.TF_TotalCount.text = this.FNovActive1.TotalCount.toString();
         FMC_Scene.TF_Count.text = this.FNovActive1.ServerList.Count.toString();
         FMC_Scene.TF_ScoreA.text = this.FNovActive1.RankPoint.toString();
         FMC_Scene.TF_ScoreB.text = this.FNovActive1.MyScore.toString();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateServerList();
      }
      
      protected function ProcessorOnGoUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGoto != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            FOnCloseWindow();
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            FOnGoto(_loc3_.Go);
         }
      }
      
      protected function ProcessorOnGetTaskUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_GET_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnFinishUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TDessertHouseTask = null;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnGetBox != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc3_ = this.FActivityTaskData.TaskList[_loc2_];
            FOnGetBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_FINISH_TASK,_loc3_.Identify);
         }
      }
      
      protected function ProcessorOnServerListUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = this.FCurPage;
         if(Boolean(FOnGetBox != null) && Boolean(this.FNovActive1) && this.FNovActive1.ServerList.Count > 0)
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_GET_SERVER_BOX,_loc2_ + 1);
         }
      }
      
      protected function ProcessorOnBuyUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(Boolean(FOnGetBox != null) && Boolean(this.FNovActive1) && !FIsPlaying)
         {
            if(this.FNovActive1.MyScore >= this.FNovActive1.CostNum)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_START_LABA);
            }
            else
            {
               _loc3_ = (this.FNovActive1.CostNum - this.FNovActive1.MyScore) * this.FNovActive1.ItemPrice;
               _loc4_ = TUtilityString.Format(this.FNovActive1.DescListNew[2],_loc3_);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_START_LABA,_loc3_,0,0,_loc4_);
            }
         }
      }
      
      protected function ProcessorOnTenUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         if(FOnGetBox != null && Boolean(this.FNovActive1))
         {
            if(this.FNovActive1.MyScore >= this.FNovActive1.TenNum)
            {
               FOnGetBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_AUTO_LABA);
            }
            else
            {
               _loc3_ = (this.FNovActive1.TenNum - this.FNovActive1.MyScore) * this.FNovActive1.ItemPrice;
               _loc4_ = TUtilityString.Format(this.FNovActive1.DescListNew[2],_loc3_);
               FOnBuyBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_AUTO_LABA,_loc3_,0,0,_loc4_);
            }
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         this.FProcessorNovActiveShop.Visible = true;
         this.FProcessorNovActiveShop.UpdateUI(this.FNovActive1);
      }
      
      protected function ProcessorOnExchangeItem(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FNovActive1))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_EXCHANGE_ITEM,param1 + 1);
         }
      }
      
      protected function ProcessorOnGetReward(param1:int) : void
      {
         if(FOnGetBox != null && Boolean(this.FNovActive1))
         {
            FOnGetBox(ACTIVITY_1_ID,TProcessorNovActive.ACTIVITY_1_GET_REWARD,param1 + 1);
         }
      }
      
      protected function ProcessorOnRewardOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TDessertHouseTask = null;
         var _loc5_:TInventories = null;
         var _loc6_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         if(FOnNewBoxOver != null && _loc2_ < this.FActivityTaskData.TaskList.length)
         {
            _loc4_ = this.FActivityTaskData.TaskList[_loc2_];
            _loc6_ = Math.min(_loc4_.Step,TASK_STEP - 1);
            _loc5_ = _loc4_.TaskAward[_loc6_];
            FOnNewBoxOver(_loc5_);
         }
      }
      
      protected function ProcessorOnServerListOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.FCurPage;
         if(FOnNewBoxOver != null && Boolean(this.FNovActive1))
         {
            FOnNewBoxOver(this.FNovActive1.ServerList.Inventories);
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
      
      protected function ProcessorOnScoreTip(param1:MouseEvent) : void
      {
      }
      
      protected function ProcessorOnTenOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FNovActive1) && this.FNovActive1.DescList.length > 4)
         {
            FOnShowHtmlTip(this.FNovActive1.DescListNew[4]);
         }
      }
      
      protected function ProcessorOnCloseAutoLog() : void
      {
         this.FUINovActiveAutoLog.Visible = false;
      }
      
      protected function ProcessorOnCloseShop() : void
      {
         this.FProcessorNovActiveShop.Visible = false;
      }
      
      protected function ProcessorOnShowRecruit(param1:uint, param2:int) : void
      {
         if(FOnShowRecruit != null)
         {
            FOnShowRecruit(param1,param2);
         }
      }
      
      protected function ProcessorOnLoadRank(param1:MouseEvent) : void
      {
         if(FOnLoadRank != null)
         {
            FOnLoadRank(ACTIVITY_1_ID);
         }
      }
      
      protected function ProcessorOnLoadLog(param1:MouseEvent) : void
      {
         if(FOnLoadLog != null)
         {
            FOnLoadLog(ACTIVITY_1_ID);
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
         if(FInitialized && this.visible)
         {
            if(this.FShowItem)
            {
               this.FShowItem.LogicsPerform();
            }
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FNovActive1 = SLogicsCore.NovActiveDatas.GetActivityByIdentify(ACTIVITY_1_ID) as TNovActive1;
         this.UpdateTask();
         this.UpdateServerList();
         this.UpdateShowItem();
         this.UpdateText();
         if(this.FIsFirst)
         {
            this.FIsFirst = false;
            this.FUINovActiveAutoLog.Load();
            this.FProcessorNovActiveShop.Load();
         }
         if(this.FProcessorNovActiveShop.Visible)
         {
            this.FProcessorNovActiveShop.UpdateUI(this.FNovActive1);
         }
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         FIsPlaying = true;
         if(param1 == MOVIE_TYPE_SINGLE)
         {
            this.UpdateLaBa();
            _loc3_ = this.FNovActive1.Result[0];
            _loc4_ = this.FNovActive1.Result[1];
            _loc5_ = this.FNovActive1.Result[2];
            TweenUtil.to(this.FLabaList0,4000,{
               "y":this.FLabaList0.y - LABA_ItemStamp * (MAX_LABACOUNT * 5 + _loc3_),
               "onUpdate":this.CheckOutArea0,
               "ease":Expo.easeOut
            });
            TweenUtil.to(this.FLabaList1,4500,{
               "y":this.FLabaList1.y - LABA_ItemStamp * (MAX_LABACOUNT * 5 + _loc4_),
               "onUpdate":this.CheckOutArea1,
               "ease":Expo.easeOut
            });
            TweenUtil.to(this.FLabaList2,5000,{
               "y":this.FLabaList2.y - LABA_ItemStamp * (MAX_LABACOUNT * 5 + _loc5_),
               "onUpdate":this.CheckOutArea2,
               "ease":Expo.easeOut,
               "onComplete":this.MovieEnd
            });
         }
         else
         {
            FIsPlaying = false;
            this.UpdateUI();
            this.FUINovActiveAutoLog.Visible = true;
            this.FUINovActiveAutoLog.UpdateUI();
         }
      }
      
      public function CheckOutArea0() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList0.y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex0 - 1)
         {
            this.FUIItems[0 + (this.FLabaIndex0 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[0 + (this.FLabaIndex0 + 1) % 2];
            ++this.FLabaIndex0;
            _loc1_.MC_Icon.gotoAndStop(this.FLabaIndex0 % MAX_LABACOUNT + 1);
         }
      }
      
      public function CheckOutArea1() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList1.y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex1 - 1)
         {
            this.FUIItems[2 + (this.FLabaIndex1 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[2 + (this.FLabaIndex1 + 1) % 2];
            ++this.FLabaIndex1;
            _loc1_.MC_Icon.gotoAndStop(this.FLabaIndex1 % MAX_LABACOUNT + 1);
         }
      }
      
      public function CheckOutArea2() : void
      {
         var _loc1_:MovieClip = null;
         if(int(Math.abs(this.FLabaList2.y - this.FLabaInitY) / LABA_ItemStamp) > this.FLabaIndex2 - 1)
         {
            this.FUIItems[4 + (this.FLabaIndex2 + 1) % 2].y += LABA_ItemStamp * 2;
            _loc1_ = this.FUIItems[4 + (this.FLabaIndex2 + 1) % 2];
            ++this.FLabaIndex2;
            _loc1_.MC_Icon.gotoAndStop(this.FLabaIndex2 % MAX_LABACOUNT + 1);
         }
      }
      
      override public function MovieEnd() : void
      {
         var _loc1_:String = null;
         var _loc2_:Vector.<Object> = null;
         var _loc3_:TConfigValue = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.DROP_ITEM_NAME) as TConfigValue;
         _loc2_ = _loc3_.Value as Vector.<Object>;
         _loc1_ = STRING_BASEACTIVITY.FORMAT_GET_SUCCESSED;
         _loc1_ += _loc2_[CONST_BASEACTIVITY.NOV_ACTIVITY_1_RANK_ITEM_1] + "*" + this.FNovActive1.ResultScore;
         FOnShowFlowText(_loc1_);
         FIsPlaying = false;
         this.UpdateUI();
      }
      
      override public function Unmount() : void
      {
         TweenUtil.removeAllTween();
         FIsPlaying = false;
         this.UpdateLaBa();
      }
   }
}

