package Processors.Game.Lobby.Lottery
{
   import Externals.SExternalCore;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.Inventories.TInventory;
   import Logics.Lottery.TLottery;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.Lottery.Components.TUILotteryInside;
   import Processors.Game.Lobby.Lottery.Components.TUILotteryOutside;
   import Processors.Game.Lobby.Lottery.Components.TUILotteryReport;
   import Resources.Constants.CONST_LOTTERY;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_LOTTERY;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowLottery extends TProcessorLobbyWindow
   {
      
      protected static const TAB_TYPE_FREE_LOTTERY:int = TProcessorLottery.TAB_TYPE_FREE_LOTTERY;
      
      protected static const TAB_TYPE_GOLD_LOTTERY:int = TProcessorLottery.TAB_TYPE_GOLD_LOTTERY;
      
      protected static const OUTSIDE_INIT_X:Number = 53;
      
      protected static const OUTSIDE_INIT_Y:Number = 73;
      
      protected static const INSIDE_INIT_X:Number = 85;
      
      protected static const INSIDE_INIT_Y:Number = 90;
      
      protected static const REPORT_INIT_X:Number = 53;
      
      protected static const REPORT_INIT_Y:Number = 73;
      
      public static const TYPE_OUTSIDE:int = 1;
      
      public static const TYPE_INSIDE:int = 2;
      
      public static const HERO_COUNT:int = 4;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FMC_Exchange:Sprite;
      
      protected var FTF_Point:TextField;
      
      protected var FBtn_Exchange:MovieClip;
      
      protected var FTF_ActivityDesc:TextField;
      
      protected var FBtn_Record:MovieClip;
      
      protected var FBtn_Recharge:MovieClip;
      
      protected var FTF_Time:TextField;
      
      protected var FBtn_ShowRecruit1:MovieClip;
      
      protected var FBtn_ShowRecruit2:MovieClip;
      
      protected var FBtn_ShowRecruit3:MovieClip;
      
      protected var FBtn_ShowRecruit4:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FChangeTabIndex:int;
      
      protected var FLottery:TLottery;
      
      protected var FUILotteryOutside:TUILotteryOutside;
      
      protected var FUILotteryInside:TUILotteryInside;
      
      protected var FUILotteryReport:TUILotteryReport;
      
      protected var FIsOutside:int;
      
      protected var FOnOverlay:Function;
      
      protected var FOnOut:Function;
      
      protected var FOnRecordUp:Function;
      
      protected var FOnExchangeUp:Function;
      
      protected var FOnFreeLotteryUp:Function;
      
      protected var FOnGoldLotteryUp:Function;
      
      protected var FTipOnOver:Function;
      
      protected var FTipOnOut:Function;
      
      protected var FOnMovieEnd:Function;
      
      protected var FOnShowHeroInfo:Function;
      
      protected var FOnShowRecruit1:Function;
      
      protected var FOnShowRecruit2:Function;
      
      protected var FOnShowRecruit3:Function;
      
      protected var FOnShowRecruit4:Function;
      
      public function TProcessorWindowLottery(param1:TUIComponent)
      {
         super(param1);
         this.FLottery = SLogicsCore.Lottery;
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         this.FUILotteryReport = new TUILotteryReport(this);
         this.FUILotteryReport.Perform_UIDispatch(this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_List]);
         this.FUILotteryReport.OnOverlay = this.SlotsOnOver;
         this.FUILotteryReport.OnOut = this.SlotsOnOut;
         this.FUILotteryReport.OnShowHeroInfo = this.ProcessorOnShowHeroInfo;
         this.FUILotteryReport.x = OUTSIDE_INIT_X;
         this.FUILotteryReport.y = OUTSIDE_INIT_Y;
         this.FUILotteryOutside = new TUILotteryOutside(this);
         this.FUILotteryOutside.Perform_UIDispatch(this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Outside]);
         this.FUILotteryOutside.OnOverlay = this.SlotsOnOver;
         this.FUILotteryOutside.OnOut = this.SlotsOnOut;
         this.FUILotteryOutside.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FUILotteryOutside.OnFreeLotteryUp = this.ProcessorOnFreeLottery;
         this.FUILotteryOutside.OnGoldLotteryUp = this.ProcessorOnGoldLottery;
         this.FUILotteryOutside.TipOnOver = this.ProcessorTipOnOver;
         this.FUILotteryOutside.TipOnOut = this.ProcessorTipOnOut;
         this.FUILotteryOutside.OnMovieEnd = this.ProcessorOnMovieEnd;
         this.FUILotteryOutside.x = OUTSIDE_INIT_X;
         this.FUILotteryOutside.y = OUTSIDE_INIT_Y;
         this.FUILotteryInside = new TUILotteryInside(this);
         this.FUILotteryInside.Perform_UIDispatch(this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Inside]);
         this.FUILotteryInside.OnOverlay = this.SlotsOnOver;
         this.FUILotteryInside.OnOut = this.SlotsOnOut;
         this.FUILotteryInside.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
         this.FUILotteryInside.OnFreeLotteryUp = this.ProcessorOnFreeLottery;
         this.FUILotteryInside.OnGoldLotteryUp = this.ProcessorOnGoldLottery;
         this.FUILotteryInside.OnMovieEnd = this.ProcessorOnMovieEnd;
         this.FUILotteryInside.x = OUTSIDE_INIT_X;
         this.FUILotteryInside.y = OUTSIDE_INIT_Y;
         this.Resources_UIDispatchWindow();
      }
      
      private function Resources_UIDispatchWindow() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FMC_Exchange = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_MC_Exchange];
         this.FTF_Point = this.FMC_Exchange[CONST_LOTTERY.RESOURCE_Link_TF_Point];
         this.FBtn_Exchange = this.FMC_Exchange[CONST_LOTTERY.RESOURCE_Link_Btn_Exchange];
         this.FTF_ActivityDesc = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_TF_ActivityDesc];
         this.FBtn_Record = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_Record];
         this.FBtn_Recharge = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_Btn_Recharge];
         this.FBtn_ShowRecruit1 = this.FMC_Scene["Btn_ShowRecruit1"];
         this.FBtn_ShowRecruit2 = this.FMC_Scene["Btn_ShowRecruit2"];
         this.FBtn_ShowRecruit3 = this.FMC_Scene["Btn_ShowRecruit3"];
         this.FBtn_ShowRecruit4 = this.FMC_Scene["Btn_ShowRecruit4"];
         _loc1_ = 1;
         while(_loc1_ < 5)
         {
            if(Boolean(this.FMC_Scene["Btn_ShowRecruit" + _loc1_]) && Boolean(this.FMC_Scene["Btn_ShowRecruit" + _loc1_].MC_Icon))
            {
               this.FMC_Scene["Btn_ShowRecruit" + _loc1_].MC_Icon.gotoAndStop(_loc1_);
            }
            _loc1_++;
         }
         this.FTF_Time = this.FMC_Scene[CONST_LOTTERY.RESOURCE_Link_TF_Time];
         TGameUtil.setButtonMode(this.FBtn_Record,true);
         TGameUtil.setButtonMode(this.FBtn_Recharge,true);
         TGameUtil.setButtonMode(this.FBtn_Exchange,true);
         TGameUtil.setButtonMode(this.FBtn_ShowRecruit1,true);
         TGameUtil.setButtonMode(this.FBtn_ShowRecruit2,true);
         TGameUtil.setButtonMode(this.FBtn_ShowRecruit3,true);
         TGameUtil.setButtonMode(this.FBtn_ShowRecruit4,true);
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:TLottery = null;
         if(this.visible)
         {
            this.FUILotteryOutside.LogicsPerform();
            this.FUILotteryInside.LogicsPerform();
            _loc1_ = SLogicsCore.Lottery;
            this.FTF_Time.text = TUtilityString.Format(STRING_LOTTERY.FORMAT_END_TIME,TGameUtil.fomatTime(_loc1_.EndTime - STimingCore.GetServerTick()));
            this.FTF_Point.text = _loc1_.Point.toString();
         }
         super.LogicsPerform();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         if(this.FBtn_Recharge)
         {
            this.FBtn_Recharge.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnRechargeUp);
         }
         if(this.FBtn_ShowRecruit1)
         {
            this.FBtn_ShowRecruit1.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit1);
         }
         if(this.FBtn_ShowRecruit2)
         {
            this.FBtn_ShowRecruit2.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit2);
         }
         if(this.FBtn_ShowRecruit3)
         {
            this.FBtn_ShowRecruit3.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit3);
         }
         if(this.FBtn_ShowRecruit4)
         {
            this.FBtn_ShowRecruit4.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnShowRecruit4);
         }
         this.FBtn_Record.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnRecordUp);
         this.FBtn_Exchange.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnExchangeUp);
         super.ResourcesPerform_UILocations();
      }
      
      protected function UpdateWindow() : void
      {
         var _loc1_:TLottery = SLogicsCore.Lottery;
         var _loc2_:String = "";
         this.FTF_ActivityDesc.text = _loc1_.ActivityDesc;
         this.FTF_Point.text = _loc1_.Point.toString();
      }
      
      protected function UpdateFUILottery() : void
      {
         this.FUILotteryOutside.SetItemInfo(this.FChangeTabIndex);
         this.FUILotteryOutside.UpdateUI();
         this.FUILotteryInside.SetItemInfo(this.FChangeTabIndex);
         this.FUILotteryInside.UpdateUI();
         this.FUILotteryReport.UpdateUI();
      }
      
      protected function UpdateHeroList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         _loc1_ = 0;
         while(_loc1_ < HERO_COUNT)
         {
            _loc2_ = this.FMC_Scene["Btn_ShowRecruit" + (_loc1_ + 1)];
            if(_loc2_)
            {
               if(_loc1_ < this.FLottery.HeroList.length)
               {
                  _loc2_.MC_Icon.gotoAndStop("ID" + this.FLottery.HeroList[_loc1_]);
               }
               else
               {
                  _loc2_.MC_Icon.gotoAndStop("ID0");
               }
            }
            _loc1_++;
         }
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.ACTIVE_Test);
         }
      }
      
      protected function SlotsOnOver(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOverlay != null)
         {
            this.FOnOverlay(this,param2);
         }
      }
      
      protected function SlotsOnOut(param1:Object, param2:TInventory) : void
      {
         if(this.FOnOut != null)
         {
            this.FOnOut(this,param2);
         }
      }
      
      protected function ProcessorOnRechargeUp(param1:MouseEvent) : void
      {
         SExternalCore.NavigateToRecharge();
      }
      
      protected function ProcessorOnRecordUp(param1:MouseEvent) : void
      {
         if(this.FOnRecordUp != null)
         {
            this.FOnRecordUp(true);
         }
      }
      
      protected function ProcessorOnExchangeUp(param1:MouseEvent) : void
      {
         if(this.FOnExchangeUp != null)
         {
            this.FOnExchangeUp(true);
         }
      }
      
      protected function ProcessorOnShowRecruit1(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit1 != null)
         {
            this.FOnShowRecruit1(0);
         }
      }
      
      protected function ProcessorOnShowRecruit2(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit2 != null)
         {
            this.FOnShowRecruit2(1);
         }
      }
      
      protected function ProcessorOnShowRecruit3(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit3 != null)
         {
            this.FOnShowRecruit3(2);
         }
      }
      
      protected function ProcessorOnShowRecruit4(param1:MouseEvent) : void
      {
         if(this.FOnShowRecruit4 != null)
         {
            this.FOnShowRecruit4(3);
         }
      }
      
      protected function ProcessorOnFreeLottery(param1:int) : void
      {
         this.FIsOutside = param1;
         if(this.FIsOutside == TYPE_OUTSIDE)
         {
            this.FUILotteryInside.HideGetEffectList();
         }
         else
         {
            this.FUILotteryOutside.HideGetEffectList();
         }
         if(this.FOnFreeLotteryUp != null)
         {
            this.FOnFreeLotteryUp(param1);
         }
      }
      
      protected function ProcessorOnGoldLottery(param1:int, param2:int) : void
      {
         this.FIsOutside = param1;
         if(this.FIsOutside == TYPE_OUTSIDE)
         {
            this.FUILotteryInside.HideGetEffectList();
         }
         else
         {
            this.FUILotteryOutside.HideGetEffectList();
         }
         if(this.FOnGoldLotteryUp != null)
         {
            this.FOnGoldLotteryUp(param1,param2);
         }
      }
      
      protected function ProcessorTipOnOver(param1:Object, param2:THint) : void
      {
         if(this.FTipOnOver != null)
         {
            this.FTipOnOver(param1,param2);
         }
      }
      
      protected function ProcessorTipOnOut(param1:Object) : void
      {
         if(this.FTipOnOut != null)
         {
            this.FTipOnOut(param1);
         }
      }
      
      protected function ProcessorOnMovieEnd(param1:Boolean) : void
      {
         if(this.FOnMovieEnd != null)
         {
            this.FOnMovieEnd(param1);
         }
         if(param1)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnShowHeroInfo(param1:uint, param2:uint) : void
      {
         if(this.FOnShowHeroInfo != null)
         {
            this.FOnShowHeroInfo(param1,param2);
         }
      }
      
      public function get OnOverlay() : Function
      {
         return this.FOnOverlay;
      }
      
      public function set OnOverlay(param1:Function) : void
      {
         this.FOnOverlay = param1;
      }
      
      public function get OnOut() : Function
      {
         return this.FOnOut;
      }
      
      public function set OnOut(param1:Function) : void
      {
         this.FOnOut = param1;
      }
      
      public function get OnRecordUp() : Function
      {
         return this.FOnRecordUp;
      }
      
      public function set OnRecordUp(param1:Function) : void
      {
         this.FOnRecordUp = param1;
      }
      
      public function get OnExchangeUp() : Function
      {
         return this.FOnExchangeUp;
      }
      
      public function set OnExchangeUp(param1:Function) : void
      {
         this.FOnExchangeUp = param1;
      }
      
      public function get OnFreeLotteryUp() : Function
      {
         return this.FOnFreeLotteryUp;
      }
      
      public function set OnFreeLotteryUp(param1:Function) : void
      {
         this.FOnFreeLotteryUp = param1;
      }
      
      public function get OnGoldLotteryUp() : Function
      {
         return this.FOnGoldLotteryUp;
      }
      
      public function set OnGoldLotteryUp(param1:Function) : void
      {
         this.FOnGoldLotteryUp = param1;
      }
      
      public function get TipOnOver() : Function
      {
         return this.FTipOnOver;
      }
      
      public function set TipOnOver(param1:Function) : void
      {
         this.FTipOnOver = param1;
      }
      
      public function get TipOnOut() : Function
      {
         return this.FTipOnOut;
      }
      
      public function set TipOnOut(param1:Function) : void
      {
         this.FTipOnOut = param1;
      }
      
      public function get OnMovieEnd() : Function
      {
         return this.FOnMovieEnd;
      }
      
      public function set OnMovieEnd(param1:Function) : void
      {
         this.FOnMovieEnd = param1;
      }
      
      public function get OnShowHeroInfo() : Function
      {
         return this.FOnShowHeroInfo;
      }
      
      public function set OnShowHeroInfo(param1:Function) : void
      {
         this.FOnShowHeroInfo = param1;
      }
      
      public function get OnShowRecruit1() : Function
      {
         return this.FOnShowRecruit1;
      }
      
      public function set OnShowRecruit1(param1:Function) : void
      {
         this.FOnShowRecruit1 = param1;
      }
      
      public function get OnShowRecruit2() : Function
      {
         return this.FOnShowRecruit2;
      }
      
      public function set OnShowRecruit2(param1:Function) : void
      {
         this.FOnShowRecruit2 = param1;
      }
      
      public function get OnShowRecruit3() : Function
      {
         return this.FOnShowRecruit3;
      }
      
      public function set OnShowRecruit3(param1:Function) : void
      {
         this.FOnShowRecruit3 = param1;
      }
      
      public function get OnShowRecruit4() : Function
      {
         return this.FOnShowRecruit4;
      }
      
      public function set OnShowRecruit4(param1:Function) : void
      {
         this.FOnShowRecruit4 = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function ChangeTabOnSwitch(param1:int) : void
      {
         if(param1 == this.FChangeTabIndex)
         {
            return;
         }
         this.FChangeTabIndex = param1;
         this.UpdateUI();
      }
      
      public function UpdateUI() : void
      {
         this.UpdateWindow();
         this.UpdateFUILottery();
         this.UpdateHeroList();
      }
      
      public function UpdateNews() : void
      {
         this.FUILotteryReport.UpdateUI();
      }
      
      public function PerformPacket_SC_FreeLotteryRet(param1:int) : void
      {
         if(this.FIsOutside == TYPE_OUTSIDE)
         {
            this.FUILotteryOutside.PerformPacket_SC_FreeLotteryRet(param1);
         }
         else
         {
            this.FUILotteryInside.PerformPacket_SC_FreeLotteryRet(param1);
         }
      }
      
      public function PerformPacket_SC_GoldLotteryRet(param1:Vector.<int>) : void
      {
         if(this.FIsOutside == TYPE_OUTSIDE)
         {
            this.FUILotteryOutside.PerformPacket_SC_GoldLotteryRet(param1);
         }
         else
         {
            this.FUILotteryInside.PerformPacket_SC_GoldLotteryRet(param1);
         }
      }
      
      public function IsMovieStart() : Boolean
      {
         return this.FUILotteryOutside.IsMoveStart || this.FUILotteryInside.IsMoveStart;
      }
      
      public function ProcessorOnLockBtn(param1:int) : void
      {
         if(param1 == TYPE_OUTSIDE)
         {
            this.FUILotteryInside.SetBtnMode(false);
         }
         else
         {
            this.FUILotteryOutside.SetBtnMode(false);
         }
      }
   }
}

