package Processors.Game.Lobby.BloodFete.Panel
{
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.BloodFete.TBloodFeteData;
   import Logics.BloodFete.TBloodFeteSingle;
   import Logics.Characters.TCharacter;
   import Logics.SLogicsCore;
   import Processors.Game.Battle.Effect.TEffectControl;
   import Processors.Game.Lobby.BloodFete.cell.GetBloodFeteFiveBtn;
   import Processors.Game.Lobby.BloodFete.cell.TBagBloodFeteCell;
   import Processors.Game.Lobby.BloodFete.cell.TFunctionalArea;
   import Processors.Game.Lobby.BloodFete.cell.TNumenCellMvc;
   import Processors.Game.Lobby.BloodFete.cell.TTextEffectMove;
   import Processors.Game.TProcessorGame;
   import Rendering.Overlayers.FeteBlood.TExpDecTip;
   import Rendering.Overlayers.FeteBlood.TGoldCallBtn;
   import Rendering.Overlayers.FeteBlood.TNameDecTip;
   import Rendering.Overlayers.FeteBlood.TNumenCellTip;
   import Resources.Constants.CONST_BLOODFETE;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowBloodFeteMainPanel extends TProcessorGame
   {
      
      protected static const RENDERINGSTATE_Disabled:int = 4;
      
      protected static const NUMENCELL_COUNT:int = 20;
      
      protected static const FIVE_COUNT:int = 5;
      
      protected var FIsInitilization:int;
      
      protected var MainPanel:Sprite = null;
      
      protected var FMC_Close:SimpleButton;
      
      protected var FMC_Help:SimpleButton;
      
      protected var FMC_ExchangeBtn:MovieClip = null;
      
      protected var FMC_FunctionalArea:MovieClip = null;
      
      protected var FMC_FunctionalArea_Father:MovieClip = null;
      
      protected var FMC_OneKey_BloodFete:MovieClip = null;
      
      protected var FMC_OneKey_Sell:MovieClip = null;
      
      protected var FMC_OneKey_Get:MovieClip = null;
      
      protected var FT_SilverCoin:TextField = null;
      
      protected var FT_Gold:TextField = null;
      
      protected var FT_Coupon:TextField = null;
      
      protected var FNumenCell:Vector.<TNumenCellMvc> = null;
      
      protected var FGetBloodFeteFiveBtn:Vector.<GetBloodFeteFiveBtn> = null;
      
      protected var FTNumenCellTip:TNumenCellTip = null;
      
      protected var FTExpDecTip:TExpDecTip = null;
      
      protected var ForPiao:Vector.<TBagBloodFeteCell> = null;
      
      protected var FBloodFeteData:TBloodFeteData = null;
      
      protected var FCharacter:TCharacter;
      
      protected var FunctionalArea:TFunctionalArea = null;
      
      protected var FTGoldCallBtn:TGoldCallBtn = null;
      
      protected var FTNameDecTip:TNameDecTip = null;
      
      protected var ThiNT:THint;
      
      protected var FFreeTextEffectMoveVect:Vector.<TTextEffectMove>;
      
      protected var FLiveTextEffectMoveVect:Vector.<TTextEffectMove>;
      
      protected var FCloseFunction:Function = null;
      
      protected var FMC_OneKey_BloodFete_Fun:Function = null;
      
      protected var FMC_OneKey_Sell_Fun:Function = null;
      
      protected var FMC_OneKey_Get_Fun:Function = null;
      
      protected var FMC_ExchangeBtn_Bag_Fun:Function = null;
      
      protected var FMC_Call:Function;
      
      protected var FThisPanelClick:Function;
      
      protected var FPiaoZi:Function;
      
      protected var FButtonHelpOnOver:Function;
      
      protected var FButtonHelpOnOut:Function;
      
      protected var FSell_Func:Function;
      
      protected var FGet_Func:Function;
      
      public function TProcessorWindowBloodFeteMainPanel(param1:TUIComponent)
      {
         super(param1);
         this.FBloodFeteData = SLogicsCore.BloodFeteDatas;
         this.FCharacter = SLogicsCore.Character;
         this.FNumenCell = new Vector.<TNumenCellMvc>(NUMENCELL_COUNT);
         this.FGetBloodFeteFiveBtn = new Vector.<GetBloodFeteFiveBtn>(FIVE_COUNT);
         this.ForPiao = new Vector.<TBagBloodFeteCell>();
         this.FFreeTextEffectMoveVect = new Vector.<TTextEffectMove>();
         this.FLiveTextEffectMoveVect = new Vector.<TTextEffectMove>();
         this.FunctionalArea = new TFunctionalArea();
         this.ThiNT = new THint();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BLOODFETE.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      public function set MP(param1:Sprite) : void
      {
         this.MainPanel = param1;
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC_Close = this.MainPanel[CONST_BLOODFETE.MC_Close];
         this.FMC_Help = this.MainPanel[CONST_BLOODFETE.MC_Help];
         this.FMC_ExchangeBtn = this.MainPanel[CONST_BLOODFETE.MC_ExchangeBtn];
         TGameUtil.setButtonMode(this.FMC_ExchangeBtn,true);
         this.FMC_FunctionalArea_Father = this.MainPanel["MC_FunctionFather"];
         this.FMC_FunctionalArea = this.FMC_FunctionalArea_Father[CONST_BLOODFETE.MC_FunctionalArea];
         this.FunctionalArea.SetThisPanel(this.FMC_FunctionalArea,this.FBloodFeteData);
         this.FunctionalArea.BackFunction = this.FunctionAreaBackFunc;
         this.FunctionalArea.PiaoString = this.PiaoZi_1;
         this.FMC_OneKey_BloodFete = this.FMC_FunctionalArea_Father[CONST_BLOODFETE.MC_OneKey_BloodFete];
         this.FMC_OneKey_Sell = this.FMC_FunctionalArea_Father[CONST_BLOODFETE.MC_OneKey_Sell];
         this.FMC_OneKey_Get = this.FMC_FunctionalArea_Father[CONST_BLOODFETE.MC_OneKey_Get];
         TGameUtil.setButtonMode(this.FMC_OneKey_Sell,true);
         TGameUtil.setButtonMode(this.FMC_OneKey_Get,true);
         this.FTNumenCellTip = new TNumenCellTip(this);
         this.FTNumenCellTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTNumenCellTip);
         this.FTExpDecTip = new TExpDecTip(this);
         this.FTExpDecTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
         this.FTNameDecTip = new TNameDecTip(this);
         this.FTNameDecTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTNameDecTip);
         this.FTGoldCallBtn = new TGoldCallBtn(this);
         this.FTGoldCallBtn.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTGoldCallBtn);
         this.FT_SilverCoin = this.MainPanel[CONST_BLOODFETE.FT_SilverCoin];
         this.FT_Gold = this.MainPanel[CONST_BLOODFETE.FT_Gold];
         this.FT_Coupon = this.MainPanel[CONST_BLOODFETE.FT_Coupon];
         this.ProcessArr();
         this.OpenThisPanel();
         this.FIsInitilization = 1;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.AddEventlistener();
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:* = 0;
         var _loc2_:uint = 0;
         var _loc3_:TTextEffectMove = null;
         var _loc4_:Boolean = false;
         if(this.FLiveTextEffectMoveVect)
         {
            _loc2_ = this.FLiveTextEffectMoveVect.length;
            _loc1_ = 0;
            while(_loc1_ < _loc2_)
            {
               _loc3_ = this.FLiveTextEffectMoveVect[_loc1_];
               _loc4_ = _loc3_.Updata();
               if(!_loc4_)
               {
                  _loc1_--;
                  _loc2_--;
               }
               _loc1_++;
            }
         }
      }
      
      public function UpdateImage() : void
      {
         this.UpdateCellImage();
      }
      
      protected function FunctionAreaBackFunc() : void
      {
         if(this.FMC_ExchangeBtn_Bag_Fun != null)
         {
            this.FMC_ExchangeBtn_Bag_Fun(0);
         }
      }
      
      protected function ProcessArr() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < NUMENCELL_COUNT)
         {
            this.FNumenCell[_loc1_] = this.MakeCell();
            this.FNumenCell[_loc1_].SetThisPanel(this.MainPanel[CONST_BLOODFETE.MC_Blood_Fete_Cell_ + _loc1_]);
            this.FNumenCell[_loc1_].Index = _loc1_;
            this.FNumenCell[_loc1_].Sell_Sell_Func = this.Sell_Sell_Func;
            this.FNumenCell[_loc1_].Sell_Get_Func = this.Sell_Get_Func;
            this.FNumenCell[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_OVER,this.TNumenCellTipOver);
            this.FNumenCell[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.TNumenCellTipOut);
            this.FNumenCell[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.TNumenCellTipMove);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < FIVE_COUNT)
         {
            this.FGetBloodFeteFiveBtn[_loc1_] = this.MakeBloodFeteFiveBtn();
            this.FGetBloodFeteFiveBtn[_loc1_].SetThisPanel(this.FMC_FunctionalArea_Father[CONST_BLOODFETE.MC_FunctionalArea]["MC_Summoner_" + _loc1_],_loc1_,this.FBloodFeteData);
            this.FGetBloodFeteFiveBtn[_loc1_].MC_CallF = this.C_C;
            this.FGetBloodFeteFiveBtn[_loc1_].ThisPanelClick = this.T_C;
            this.FGetBloodFeteFiveBtn[_loc1_].M_C_F = this.M_C_F;
            this.FGetBloodFeteFiveBtn[_loc1_].O_U_F = this.O_U_F;
            this.FGetBloodFeteFiveBtn[_loc1_].O_V_F = this.O_V_F;
            _loc1_++;
         }
      }
      
      public function updateFiveIsCanClick() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < FIVE_COUNT)
         {
            this.FGetBloodFeteFiveBtn[_loc1_].IsCanClick = 1;
            _loc1_++;
         }
      }
      
      protected function TNumenCellTipOver(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         var _loc3_:int = int(_loc2_.name.split("_")[4]);
         if(this.FTNumenCellTip != null)
         {
            if(this.FNumenCell[_loc3_].FBFS.Type == 3 || this.FNumenCell[_loc3_].FBFS.Type == 2 || this.FNumenCell[_loc3_].FBFS.Type == 4)
            {
               if(this.FNumenCell[_loc3_].FBFS.Type == 3)
               {
                  if(this.FTGoldCallBtn != null)
                  {
                     this.ThiNT.Content = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_CallBtnTipHtml_Exp,this.FNumenCell[_loc3_].FBFS.Name,this.FNumenCell[_loc3_].FBFS.DevourExp);
                     this.FTGoldCallBtn.Context = this.ThiNT;
                     this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
                     this.FTGoldCallBtn.Show();
                  }
               }
               else if(this.FNumenCell[_loc3_].FBFS.Type == 2)
               {
                  this.FTExpDecTip.Context = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Function_Pric,this.FNumenCell[_loc3_].FBFS.Price);
                  this.FTExpDecTip.Render(FUICore.MouseCoordinate);
                  this.FTExpDecTip.Show();
               }
               else if(this.FNumenCell[_loc3_].FBFS.Type == 4)
               {
                  this.FTExpDecTip.Context = STRING_FETEBLOODMAINMANAGE.STRING_Function_For_dUIhUAN;
                  this.FTExpDecTip.Render(FUICore.MouseCoordinate);
                  this.FTExpDecTip.Show();
               }
            }
            else
            {
               this.FTNumenCellTip.Context = this.FNumenCell[_loc3_].FBFS;
               this.FTNumenCellTip.Render(FUICore.MouseCoordinate);
               this.FTNumenCellTip.Show();
            }
         }
      }
      
      protected function TNumenCellTipOut(param1:MouseEvent) : void
      {
         if(this.FTNumenCellTip != null)
         {
            this.FTExpDecTip.Hide();
            this.FTNumenCellTip.Hide();
            this.FTGoldCallBtn.Hide();
         }
      }
      
      protected function TNumenCellTipMove(param1:MouseEvent) : void
      {
         if(this.FTNumenCellTip != null)
         {
            this.FTExpDecTip.Render(FUICore.MouseCoordinate);
            this.FTNumenCellTip.Render(FUICore.MouseCoordinate);
            this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function M_C_F(param1:int) : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
         }
         if(this.FTNameDecTip != null)
         {
            this.FTNameDecTip.Render(FUICore.MouseCoordinate);
         }
      }
      
      protected function O_U_F(param1:int) : void
      {
         if(this.FTGoldCallBtn != null)
         {
            this.FTGoldCallBtn.Hide();
         }
         if(this.FTNameDecTip != null)
         {
            this.FTNameDecTip.Hide();
         }
      }
      
      protected function O_V_F(param1:int, param2:int = 0) : void
      {
         if(param2)
         {
            if(this.FTGoldCallBtn != null)
            {
               this.ThiNT.Content = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_DIAOLUO_Vec[param1],STRING_FETEBLOODMAINMANAGE.STRING_NameVec[param1],SLogicsCore.BloodFeteDatas.CallCostPri[param1]);
               this.FTGoldCallBtn.Context = this.ThiNT;
               this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
               this.FTGoldCallBtn.Show();
            }
         }
         else if(this.FTGoldCallBtn != null)
         {
            this.ThiNT.Content = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_CallBtnTipHtml,SLogicsCore.BloodFeteDatas.CallCostPri[param1],this.FBloodFeteData.CallBtnCountFree == 0 ? this.FBloodFeteData.CallCast / 2 : this.FBloodFeteData.CallCast);
            this.FTGoldCallBtn.Context = this.ThiNT;
            this.FTGoldCallBtn.Render(FUICore.MouseCoordinate);
            this.FTGoldCallBtn.Show();
         }
      }
      
      protected function Sell_Sell_Func(param1:TBloodFeteSingle) : void
      {
         if(this.FSell_Func != null)
         {
            this.FSell_Func(param1);
         }
      }
      
      protected function Sell_Get_Func(param1:TBloodFeteSingle) : void
      {
         if(this.FGet_Func != null)
         {
            this.FGet_Func(param1);
         }
      }
      
      public function set Sell_Func(param1:Function) : void
      {
         this.FSell_Func = param1;
      }
      
      public function set Get_Func(param1:Function) : void
      {
         this.FGet_Func = param1;
      }
      
      protected function C_C(param1:int) : void
      {
         if(this.FMC_Call != null)
         {
            this.FMC_Call(param1);
         }
      }
      
      protected function T_C(param1:int) : void
      {
         if(this.FThisPanelClick != null)
         {
            this.FThisPanelClick(param1);
         }
      }
      
      protected function MakeCell() : TNumenCellMvc
      {
         return new TNumenCellMvc();
      }
      
      protected function MakeBloodFeteFiveBtn() : GetBloodFeteFiveBtn
      {
         return new GetBloodFeteFiveBtn();
      }
      
      protected function AddEventlistener() : void
      {
         this.FMC_Close.addEventListener(MouseEvent.CLICK,this.ClickHandler);
         this.FMC_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnHelpMouseMove);
         this.FMC_Help.addEventListener(MouseEvent.ROLL_OUT,this.OnHelpRoleOut);
         this.FMC_ExchangeBtn.addEventListener(MouseEvent.CLICK,this.ClickHandler);
         this.FMC_OneKey_BloodFete.addEventListener(MouseEvent.CLICK,this.ClickHandler);
         this.FMC_OneKey_Sell.addEventListener(MouseEvent.CLICK,this.ClickHandler);
         this.FMC_OneKey_Get.addEventListener(MouseEvent.CLICK,this.ClickHandler);
      }
      
      public function set CloseFunction(param1:Function) : void
      {
         this.FCloseFunction = param1;
      }
      
      public function get CloseFunction() : Function
      {
         return this.FCloseFunction;
      }
      
      public function set MC_ExchangeBtn_Bag_Fun(param1:Function) : void
      {
         this.FMC_ExchangeBtn_Bag_Fun = param1;
      }
      
      protected function ClickHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Close:
               if(this.FCloseFunction != null)
               {
                  this.FCloseFunction();
               }
               break;
            case this.FMC_ExchangeBtn:
               if(this.FMC_ExchangeBtn.currentFrame != RENDERINGSTATE_Disabled)
               {
                  if(this.FMC_ExchangeBtn_Bag_Fun != null)
                  {
                     this.FMC_ExchangeBtn_Bag_Fun(1);
                  }
               }
               break;
            case this.FMC_OneKey_BloodFete:
               if(this.FMC_ExchangeBtn.currentFrame != RENDERINGSTATE_Disabled)
               {
                  if(this.FMC_OneKey_BloodFete_Fun != null)
                  {
                     this.FMC_OneKey_BloodFete_Fun();
                  }
               }
               break;
            case this.FMC_OneKey_Sell:
               if(this.FMC_ExchangeBtn.currentFrame != RENDERINGSTATE_Disabled)
               {
                  if(this.FMC_OneKey_Sell_Fun != null)
                  {
                     this.FMC_OneKey_Sell_Fun();
                  }
               }
               break;
            case this.FMC_OneKey_Get:
               if(this.FMC_ExchangeBtn.currentFrame != RENDERINGSTATE_Disabled)
               {
                  if(this.FMC_OneKey_Get_Fun != null)
                  {
                     this.FMC_OneKey_Get_Fun();
                  }
               }
         }
      }
      
      protected function OnHelpMouseMove(param1:MouseEvent) : void
      {
         if(this.FButtonHelpOnOver != null)
         {
            this.FButtonHelpOnOver(param1);
         }
      }
      
      protected function OnHelpRoleOut(param1:MouseEvent) : void
      {
         if(this.FButtonHelpOnOut != null)
         {
            this.FButtonHelpOnOut(param1);
         }
      }
      
      public function MoveTextField(param1:int, param2:int) : void
      {
         var _loc3_:TTextEffectMove = null;
         if(this.FFreeTextEffectMoveVect.length > 0)
         {
            _loc3_ = this.FFreeTextEffectMoveVect.shift();
         }
         else
         {
            _loc3_ = new TTextEffectMove();
            _loc3_.BackThis = this.BackTextField;
         }
         _loc3_.SetPrice(param1);
         this.MainPanel.addChild(_loc3_);
         _loc3_.x = this.FNumenCell[param2].ThisPanel.x;
         _loc3_.y = this.FNumenCell[param2].ThisPanel.y + this.FNumenCell[param2].ThisPanel.height / 2;
         this.FLiveTextEffectMoveVect.push(_loc3_);
      }
      
      public function BackTextField(param1:TTextEffectMove) : void
      {
         var _loc2_:uint = 0;
         this.FFreeTextEffectMoveVect.push(param1);
         param1.parent.removeChild(param1);
         _loc2_ = this.FLiveTextEffectMoveVect.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this.FLiveTextEffectMoveVect.splice(_loc2_,1);
         }
      }
      
      public function MoveEffect(param1:TBloodFeteSingle) : void
      {
         var _loc2_:TBagBloodFeteCell = null;
         if(param1.ThisIsAccident < 0)
         {
            return;
         }
         _loc2_ = new TBagBloodFeteCell();
         _loc2_.BloodFeteSingle = new TBloodFeteSingle();
         _loc2_.BloodFeteSingle.Identifier = param1.Identifier;
         _loc2_.BloodFeteSingle.EffectId = param1.EffectId;
         _loc2_.BloodFeteSingle.IdentifierUInt64.High = param1.IdentifierUInt64.High;
         _loc2_.BloodFeteSingle.IdentifierUInt64.Low = param1.IdentifierUInt64.Low;
         _loc2_.x = this.FNumenCell[param1.ThisIsAccident].ThisPanel.x;
         _loc2_.y = this.FNumenCell[param1.ThisIsAccident].ThisPanel.y;
         this.MainPanel.addChild(_loc2_);
         this.ForPiao.push(_loc2_);
         TEffectControl.ShowMoveEffect(_loc2_,this.FMC_FunctionalArea_Father.x + this.FunctionalArea.SM_Bag_Btn.x + 50,this.FMC_FunctionalArea_Father.y + this.FunctionalArea.SM_Bag_Btn.y + 70,600,this.EndBigEffect);
      }
      
      public function EndBigEffect(param1:Object) : void
      {
         var _loc2_:TBagBloodFeteCell = param1 as TBagBloodFeteCell;
         this.DeletePiaoById64(_loc2_);
         this.MainPanel.removeChild(_loc2_);
      }
      
      protected function DeletePiaoById64(param1:TBagBloodFeteCell) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.ForPiao.length)
         {
            if(this.ForPiao[_loc2_].BloodFeteSingle.IdentifierUInt64.High == param1.BloodFeteSingle.IdentifierUInt64.High && this.ForPiao[_loc2_].BloodFeteSingle.IdentifierUInt64.Low == param1.BloodFeteSingle.IdentifierUInt64.Low)
            {
               this.ForPiao.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      protected function UpdateCellImage() : void
      {
         var _loc1_:int = 0;
         if(this.FBloodFeteData.NumenBagBloodFete != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FBloodFeteData.NumenBagBloodFete.length)
            {
               this.FNumenCell[_loc1_].UpdateImage();
               _loc1_++;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < this.ForPiao.length)
         {
            this.ForPiao[_loc1_].UpdateImage();
            _loc1_++;
         }
      }
      
      public function OpenThisPanel() : void
      {
         if(!this.FIsInitilization)
         {
            return;
         }
         this.reflashVip();
         this.UpdateCell();
      }
      
      public function reflashVip() : void
      {
         TGameUtil.setButtonMode(this.FMC_OneKey_BloodFete,Boolean(SLogicsCore.Character.VipData.AddFollowBloodBoundAutoSynthesis));
      }
      
      public function UpdateCell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < NUMENCELL_COUNT)
         {
            if(_loc1_ >= this.FBloodFeteData.NumenBagBloodFete.length)
            {
               this.FNumenCell[_loc1_].VISIBLE = false;
            }
            else
            {
               this.FBloodFeteData.NumenBagBloodFete[_loc1_].PositionIndex = _loc1_;
               this.FNumenCell[_loc1_].UpdateData(this.FBloodFeteData.NumenBagBloodFete[_loc1_]);
               this.FNumenCell[_loc1_].VISIBLE = true;
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < FIVE_COUNT)
         {
            this.FGetBloodFeteFiveBtn[_loc1_].UpdateState();
            _loc1_++;
         }
         this.ReflashFunctionArea();
      }
      
      protected function PiaoZi_1() : void
      {
         if(this.FPiaoZi != null)
         {
            this.FPiaoZi(TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.Tip_3,SLogicsCore.Character.VipData.AddFollowBloodBoundAutoSynthesis));
         }
      }
      
      public function UpdateOnline() : void
      {
         this.FGetBloodFeteFiveBtn[3].UpdateOnline();
      }
      
      public function ReflashFunctionArea() : void
      {
         this.FunctionalArea.UpdateData();
      }
      
      public function updateMoney() : void
      {
         this.FT_SilverCoin.text = this.FCharacter.CreditSilverCoin.ToString();
         this.FT_Gold.text = this.FCharacter.CreditGold.toString();
         this.FT_Coupon.text = this.FCharacter.CreditGiftCertificate.toString();
      }
      
      public function get IsInitilization() : int
      {
         return this.FIsInitilization;
      }
      
      public function set MC_Call(param1:Function) : void
      {
         this.FMC_Call = param1;
      }
      
      public function set ThisPanelClick(param1:Function) : void
      {
         this.FThisPanelClick = param1;
      }
      
      public function set MC_OneKey_BloodFete_Fun(param1:Function) : void
      {
         this.FMC_OneKey_BloodFete_Fun = param1;
      }
      
      public function set MC_OneKey_Sell_Fun(param1:Function) : void
      {
         this.FMC_OneKey_Sell_Fun = param1;
      }
      
      public function set MC_OneKey_Get_Fun(param1:Function) : void
      {
         this.FMC_OneKey_Get_Fun = param1;
      }
      
      public function set PiaoZi(param1:Function) : void
      {
         this.FPiaoZi = param1;
      }
      
      public function set ButtonHelpOnOver(param1:Function) : void
      {
         this.FButtonHelpOnOver = param1;
      }
      
      public function set ButtonHelpOnOut(param1:Function) : void
      {
         this.FButtonHelpOnOut = param1;
      }
      
      public function get MC_FunctionalArea_Father() : MovieClip
      {
         return this.FMC_FunctionalArea_Father;
      }
      
      public function ResetBloodFeteFiveBtn() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < FIVE_COUNT)
         {
            this.FGetBloodFeteFiveBtn[_loc1_].UpdateState();
            _loc1_++;
         }
      }
   }
}

