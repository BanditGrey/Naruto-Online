package Processors.Game.Lobby.Exercise.JulyActive.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.JulyActive.TJulyActive2;
   import Logics.Exercise.TBaseActivity;
   import Logics.Exercise.TBaseBox;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Exercise.JulyActive.TProcessorJulyActive;
   import Resources.Strings.STRING_BASEACTIVITY;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.easing.TweenUtil;
   
   public class TUIJulyActive2 extends TUIBaseWindow
   {
      
      protected static const EXCHANGE_BOX_COUNT:int = 5;
      
      protected static const KILL_BOX_COUNT:int = 4;
      
      protected static const LUCKY_NAME_COUNT:int = 3;
      
      protected static const ACTIVITY_2_ID:int = 2;
      
      protected static const MOVIE_TYPE_FIGHT_BOSS:int = 1;
      
      protected static const MOVIE_TYPE_BOSS_DIED:int = 2;
      
      protected var FJulyActive2:TJulyActive2;
      
      protected var FExchangeBoxList:Vector.<MovieClip>;
      
      protected var FKillBoxList:Vector.<MovieClip>;
      
      protected var FUIPage_ExchangeBox:TUIPage;
      
      protected var FTotalPage_ExchangeBox:int;
      
      protected var FCurPage_ExchangeBox:int;
      
      protected var FUIPage_KillBox:TUIPage;
      
      protected var FTotalPage_KillBox:int;
      
      protected var FCurPage_KillBox:int;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      public function TUIJulyActive2(param1:TUIComponent)
      {
         super(param1);
         this.FExchangeBoxList = new Vector.<MovieClip>(EXCHANGE_BOX_COUNT);
         this.FKillBoxList = new Vector.<MovieClip>(KILL_BOX_COUNT);
         this.FUIPage_ExchangeBox = new TUIPage(this);
         this.FUIPage_KillBox = new TUIPage(this);
      }
      
      override protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         super.Resources_UIDispatch(param1);
         _loc2_ = 0;
         while(_loc2_ < EXCHANGE_BOX_COUNT)
         {
            param1 = FMC_Scene["MC_ExchangeBox" + _loc2_];
            TGameUtil.setButtonMode(param1.BTN_Exchange,true);
            param1.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeBoxUp);
            param1.MC_Icon.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnExchangeBoxOver);
            param1.MC_Icon.addEventListener(MouseEvent.ROLL_OUT,this.ProcessorOnExchangeBoxOut);
            this.FExchangeBoxList[_loc2_] = param1;
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < KILL_BOX_COUNT)
         {
            param1 = FMC_Scene["MC_KillBox" + _loc2_];
            param1.MC_Tip.buttonMode = true;
            param1.MC_Tip.addEventListener(MouseEvent.CLICK,this.ProcessorOnKillBoxUp);
            param1.MC_Tip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnKillBoxOver);
            param1.MC_Tip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
            this.FExchangeBoxList[_loc2_] = param1;
            _loc2_++;
         }
         TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
         FMC_Scene.BTN_Exchange.addEventListener(MouseEvent.CLICK,this.ProcessorOnExchangeHeroUp);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnHeroOver);
         FMC_Scene.MC_Hero.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Recruit,true);
         FMC_Scene.BTN_Recruit.addEventListener(MouseEvent.CLICK,this.ProcessorOnHeroUp);
         FMC_Scene.MC_LuckyBox.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLuckyBoxOver);
         FMC_Scene.MC_LuckyBox.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_LuckyTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnLuckyTipOver);
         FMC_Scene.MC_LuckyTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         FMC_Scene.MC_AllServerBoxTip.buttonMode = true;
         FMC_Scene.MC_AllServerBoxTip.addEventListener(MouseEvent.CLICK,this.ProcessorOnAllServerBoxUp);
         FMC_Scene.MC_AllServerBoxTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnAllServerBoxOver);
         FMC_Scene.MC_AllServerBoxTip.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnNewBoxOut);
         FMC_Scene.MC_Boss.MC_Pic.buttonMode = true;
         FMC_Scene.MC_Boss.MC_Pic.addEventListener(MouseEvent.CLICK,this.ProcessorOnBossUp);
         FMC_Scene.MC_Boss.MC_Pic.addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBossOver);
         FMC_Scene.MC_Boss.MC_Pic.addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlTip);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Log,true);
         FMC_Scene.BTN_Log.addEventListener(MouseEvent.CLICK,this.ProcessorOnLoadLog);
         TGameUtil.setButtonMode(FMC_Scene.BTN_Desc,true);
         FMC_Scene.BTN_Desc.addEventListener(MouseEvent.CLICK,this.ProcessorOnShowDesc);
         this.FUIPage_ExchangeBox.ButtonPrevious.Substrate = FMC_Scene.Btn_Left;
         this.FUIPage_ExchangeBox.ButtonNext.Substrate = FMC_Scene.Btn_Right;
         this.FUIPage_ExchangeBox.TotalQuantity = this.FTotalPage_ExchangeBox;
         this.FUIPage_ExchangeBox.PageSize = EXCHANGE_BOX_COUNT;
         this.FUIPage_ExchangeBox.PageIndex = 0;
         this.FCurPage_ExchangeBox = 0;
         this.FUIPage_ExchangeBox.OnChangePage = this.ProcessorPageOnChangeExchangeBox;
         this.FUIPage_KillBox.ButtonPrevious.Substrate = FMC_Scene.BTN_Up;
         this.FUIPage_KillBox.ButtonNext.Substrate = FMC_Scene.BTN_Down;
         this.FUIPage_KillBox.TotalQuantity = this.FTotalPage_KillBox;
         this.FUIPage_KillBox.PageSize = KILL_BOX_COUNT;
         this.FUIPage_KillBox.PageIndex = 0;
         this.FCurPage_KillBox = 0;
         this.FUIPage_KillBox.OnChangePage = this.ProcessorPageOnChangeKillBox;
         this.FMC_Mask = FMC_Scene.MC_Boss.MC_Bar.MC_Bar.MC_Mask;
         if(this.FMC_Mask)
         {
            this.FBarMaxWidth = this.FMC_Mask.width;
         }
      }
      
      protected function UpdateHero() : void
      {
         var _loc1_:TBaseBox = null;
         _loc1_ = this.FJulyActive2.ExchangeHero;
         if(_loc1_.Status == TBaseActivity.STATUS_GETED)
         {
            FMC_Scene.MC_Got.visible = true;
            TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
         }
         else
         {
            FMC_Scene.MC_Got.visible = false;
            if(this.FJulyActive2.Score >= _loc1_.Price)
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,true);
            }
            else
            {
               TGameUtil.setButtonMode(FMC_Scene.BTN_Exchange,false);
            }
         }
         FMC_Scene.TF_Price.text = _loc1_.Price.toString();
      }
      
      protected function UpdateExchangeBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage_ExchangeBox.TotalQuantity = this.FJulyActive2.ExchangeBoxList.length;
         this.FUIPage_ExchangeBox.Update();
         _loc1_ = 0;
         while(_loc1_ < EXCHANGE_BOX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage_ExchangeBox * EXCHANGE_BOX_COUNT;
            _loc4_ = FMC_Scene["MC_ExchangeBox" + _loc1_];
            if(_loc2_ < this.FJulyActive2.ExchangeBoxList.length)
            {
               _loc4_.visible = true;
               _loc4_.MC_Icon.gotoAndStop(_loc2_ + 1);
               _loc5_ = this.FJulyActive2.ExchangeBoxList[_loc2_];
               _loc4_.TF_Price.text = "*" + _loc5_.Price.toString();
               _loc4_.TF_Limit.text = TUtilityString.Format(STRING_BASEACTIVITY.FORMAT_LIMIT_COUNT,_loc5_.Count);
               if(this.FJulyActive2.Score >= _loc5_.Price && _loc5_.Count > 0)
               {
                  TGameUtil.setButtonMode(_loc4_.BTN_Exchange,true);
               }
               else
               {
                  TGameUtil.setButtonMode(_loc4_.BTN_Exchange,false);
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateKillBox() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc5_:TBaseBox = null;
         this.FUIPage_KillBox.TotalQuantity = this.FJulyActive2.KillBoxList.length;
         this.FUIPage_KillBox.Update();
         _loc1_ = 0;
         while(_loc1_ < KILL_BOX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage_KillBox * KILL_BOX_COUNT;
            _loc4_ = FMC_Scene["MC_KillBox" + _loc1_];
            if(_loc2_ < this.FJulyActive2.KillBoxList.length)
            {
               _loc4_.visible = true;
               _loc5_ = this.FJulyActive2.KillBoxList[_loc2_];
               _loc4_.TF_Text.text = _loc5_.Desc1;
               _loc4_.MC_Icon.MC_Icon.gotoAndStop(_loc2_ + 1);
               if(_loc5_.Status == TBaseActivity.STATUS_CANNOTGET)
               {
                  _loc4_.MC_GetBox.visible = false;
                  _loc4_.MC_Got.visible = false;
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc4_.MC_GetBox.visible = true;
                  _loc4_.MC_Got.visible = false;
               }
               else
               {
                  _loc4_.MC_GetBox.visible = false;
                  _loc4_.MC_Got.visible = true;
               }
            }
            else
            {
               _loc4_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateBoss() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         FMC_Scene.MC_Boss.MC_Bar.TF_Count.text = this.FJulyActive2.CurHp + "/" + this.FJulyActive2.MaxHp;
         _loc1_ = Number(this.FJulyActive2.CurHp / this.FJulyActive2.MaxHp) * this.FBarMaxWidth;
         _loc2_ = Math.min(_loc1_,this.FBarMaxWidth);
         TweenUtil.to(this.FMC_Mask,1000,{"width":_loc2_});
         FMC_Scene.MC_Boss.MC_Pic.MC_Pic.gotoAndStop(this.FJulyActive2.BossID);
         FMC_Scene.TF_Count.text = this.FJulyActive2.Score.toString();
         FMC_Scene.TF_Power.text = this.FJulyActive2.MyPower + "/" + this.FJulyActive2.MaxPower;
         FMC_Scene.TF_AllServer.text = TUtilityString.Format(this.FJulyActive2.DescListNew[3],this.FJulyActive2.AllKillCount);
         FMC_Scene.TF_Limit.text = "*" + int(this.FJulyActive2.AllKillCount / this.FJulyActive2.AllKillNeedCount);
      }
      
      protected function UpdateBtn() : void
      {
         if(this.FJulyActive2.AllKillStatus == TBaseActivity.STATUS_CANGET)
         {
            FMC_Scene.MC_Click.visible = true;
         }
         else
         {
            FMC_Scene.MC_Click.visible = false;
         }
         if(this.FJulyActive2.KillCount == 0)
         {
            FMC_Scene.MC_Tag.visible = true;
         }
         else
         {
            FMC_Scene.MC_Tag.visible = false;
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         FMC_Scene.TF_Date.text = TUtilityString.Format(STRING_BASEACTIVITY.FormatString_ActivityTimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FJulyActive2.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date((STimingCore.GetClientShowTime(this.FJulyActive2.EndTime) - 1) * 1000)));
         FMC_Scene.TF_Desc.text = this.FJulyActive2.DescListNew[1].toString();
         FMC_Scene.TF_KillCount.text = this.FJulyActive2.KillCount.toString();
         _loc1_ = 0;
         while(_loc1_ < LUCKY_NAME_COUNT)
         {
            if(_loc1_ < this.FJulyActive2.LuckyName.length)
            {
               FMC_Scene["TF_Name" + _loc1_].text = this.FJulyActive2.LuckyName[_loc1_];
            }
            else
            {
               FMC_Scene["TF_Name" + _loc1_].text = this.FJulyActive2.DescListNew[7];
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChangeExchangeBox(param1:Object, param2:int) : void
      {
         this.FCurPage_ExchangeBox = param2;
         this.UpdateExchangeBox();
      }
      
      protected function ProcessorPageOnChangeKillBox(param1:Object, param2:int) : void
      {
         this.FCurPage_KillBox = param2;
         this.UpdateKillBox();
      }
      
      protected function ProcessorOnExchangeHeroUp(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         if(Boolean(FOnGetBox != null && this.FJulyActive2) && Boolean(this.FJulyActive2.ExchangeHero) && this.FJulyActive2.ExchangeHero.Status != TBaseActivity.STATUS_GETED)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJulyActive.ACTIVITY_2_EXCHANGE_HERO);
         }
      }
      
      protected function ProcessorOnExchangeBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(14));
         _loc3_ = _loc2_ + this.FCurPage_ExchangeBox * EXCHANGE_BOX_COUNT;
         if(Boolean(FOnGetBox != null) && Boolean(this.FJulyActive2) && _loc2_ < this.FJulyActive2.ExchangeBoxList.length)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJulyActive.ACTIVITY_2_EXCHANGE_BOX,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnKillBoxUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(10));
         _loc3_ = _loc2_ + this.FCurPage_KillBox * KILL_BOX_COUNT;
         if(Boolean(FOnGetBox != null && this.FJulyActive2) && Boolean(_loc2_ < this.FJulyActive2.KillBoxList.length) && this.FJulyActive2.KillBoxList[_loc3_].Status == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJulyActive.ACTIVITY_2_GET_KILL_BOX,_loc3_ + 1);
         }
      }
      
      protected function ProcessorOnAllServerBoxUp(param1:MouseEvent) : void
      {
         if(Boolean(FOnGetBox != null) && Boolean(this.FJulyActive2) && this.FJulyActive2.AllKillStatus == TBaseActivity.STATUS_CANGET)
         {
            FOnGetBox(ACTIVITY_2_ID,TProcessorJulyActive.ACTIVITY_2_GET_ALL_SERVER_BOX);
         }
      }
      
      protected function ProcessorOnBossUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(FOnGetBox != null && Boolean(this.FJulyActive2))
         {
            if(this.FJulyActive2.MyPower >= this.FJulyActive2.NeedPower)
            {
               FOnGetBox(ACTIVITY_2_ID,TProcessorJulyActive.ACTIVITY_2_FIGHT_BOSS);
            }
            else
            {
               _loc2_ = (this.FJulyActive2.NeedPower - this.FJulyActive2.MyPower) * this.FJulyActive2.PowerPrice;
               FOnBuyBox(ACTIVITY_2_ID,TProcessorJulyActive.ACTIVITY_2_FIGHT_BOSS,_loc2_);
            }
         }
      }
      
      protected function ProcessorOnExchangeBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(14));
         _loc3_ = _loc2_ + this.FCurPage_ExchangeBox * EXCHANGE_BOX_COUNT;
         if(Boolean(FOnItemOver != null) && Boolean(this.FJulyActive2) && _loc2_ < this.FJulyActive2.ExchangeBoxList.length)
         {
            _loc4_ = this.FJulyActive2.ExchangeBoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOver(this,_loc4_);
         }
      }
      
      protected function ProcessorOnExchangeBoxOut(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TInventory = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(14));
         _loc3_ = _loc2_ + this.FCurPage_ExchangeBox * EXCHANGE_BOX_COUNT;
         if(Boolean(FOnItemOut != null) && Boolean(this.FJulyActive2) && _loc2_ < this.FJulyActive2.ExchangeBoxList.length)
         {
            _loc4_ = this.FJulyActive2.ExchangeBoxList[_loc3_].Inventories.GetInventoryByIndex(0);
            FOnItemOut(this,_loc4_);
         }
      }
      
      protected function ProcessorOnKillBoxOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(10));
         _loc3_ = _loc2_ + this.FCurPage_KillBox * KILL_BOX_COUNT;
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FJulyActive2) && _loc2_ < this.FJulyActive2.KillBoxList.length)
         {
            FOnNewBoxOver(this.FJulyActive2.KillBoxList[_loc3_].Inventories);
         }
      }
      
      protected function ProcessorOnLuckyBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FJulyActive2) && Boolean(this.FJulyActive2.LuckyItems))
         {
            FOnNewBoxOver(this.FJulyActive2.LuckyItems);
         }
      }
      
      protected function ProcessorOnLuckyTipOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive2) && this.FJulyActive2.DescList.length > 10)
         {
            FOnShowHtmlTip(this.FJulyActive2.DescListNew[10]);
         }
      }
      
      protected function ProcessorOnAllServerBoxOver(param1:MouseEvent) : void
      {
         if(Boolean(FOnNewBoxOver != null) && Boolean(this.FJulyActive2) && Boolean(this.FJulyActive2.AllKillItems))
         {
            FOnNewBoxOver(this.FJulyActive2.AllKillItems);
         }
      }
      
      protected function ProcessorOnBossOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive2) && this.FJulyActive2.DescList.length > 6)
         {
            FOnShowHtmlTip(this.FJulyActive2.DescListNew[3 + this.FJulyActive2.BossID]);
         }
      }
      
      protected function ProcessorOnHeroOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(Boolean(FOnShowHtmlTip != null) && Boolean(this.FJulyActive2) && this.FJulyActive2.DescList.length > 2)
         {
            FOnShowHtmlTip(this.FJulyActive2.DescListNew[2]);
         }
      }
      
      protected function ProcessorOnHeroUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         if(Boolean(FOnShowRecruit != null) && Boolean(this.FJulyActive2) && Boolean(this.FJulyActive2.ExchangeHero))
         {
            _loc3_ = uint(this.FJulyActive2.ExchangeHero.Identify);
            FOnShowRecruit(_loc3_,this.FJulyActive2.ExchangeHero.Type);
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
         if(FInitialized && this.visible)
         {
         }
      }
      
      override public function UpdateUI() : void
      {
         this.FJulyActive2 = SLogicsCore.JulyActiveDatas.GetActivityByIdentify(ACTIVITY_2_ID) as TJulyActive2;
         this.UpdateHero();
         this.UpdateBoss();
         this.UpdateExchangeBox();
         this.UpdateKillBox();
         this.UpdateBtn();
         this.UpdateText();
      }
      
      override public function PlayMovie(param1:int = 0, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc6_:TInventories = null;
         switch(param1)
         {
            case MOVIE_TYPE_FIGHT_BOSS:
               FMC_Scene.MC_Boss.MC_Pic.gotoAndPlay(1);
               break;
            case MOVIE_TYPE_BOSS_DIED:
               FMC_Scene.MC_Boss.MC_Die.gotoAndPlay(1);
               FMC_Scene.MC_Boss.MC_Pic.gotoAndPlay(1);
         }
      }
      
      override public function MovieEnd() : void
      {
      }
   }
}

