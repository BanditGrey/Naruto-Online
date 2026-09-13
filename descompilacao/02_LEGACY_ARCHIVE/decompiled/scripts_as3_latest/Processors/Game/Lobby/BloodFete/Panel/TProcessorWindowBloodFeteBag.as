package Processors.Game.Lobby.BloodFete.Panel
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.TBounds;
   import Foundation.Common.TCoordinate;
   import Foundation.Common.THint;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.BloodFete.TBloodFeteData;
   import Logics.BloodFete.TBloodFeteSingle;
   import Logics.Characters.TCharacter;
   import Logics.Characters.THero;
   import Logics.Characters.THeros;
   import Logics.DatebaseVO.VO.TFollowBloodBound;
   import Logics.DatebaseVO.VO.TRoleModel;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.BloodFete.cell.TBagBloodFeteCell;
   import Processors.Game.Lobby.BloodFete.cell.TMouseBloodFete;
   import Processors.Game.Lobby.BloodFete.cell.TNumenBagCellMvc;
   import Processors.Game.Lobby.Components.TUIHero;
   import Processors.Game.TProcessorGame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.FeteBlood.TExpDecTip;
   import Rendering.Overlayers.FeteBlood.TGoldCallBtn;
   import Rendering.Overlayers.FeteBlood.TRealCellTip;
   import Resources.Constants.CONST_BLOODFETE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_FETEBLOODMAINMANAGE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowBloodFeteBag extends TProcessorGame
   {
      
      public static const C_TEN:int = 10;
      
      public static const C_SIX:int = 6;
      
      public static const C_TWENTY:int = 20;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      protected var MainPanel:Sprite = null;
      
      protected var FUIBloodPage:TUIPage;
      
      protected var FBloodPageIndex:int;
      
      protected var FMC_HeroPosition:Sprite;
      
      protected var FTF_FightingCapacity:TextField;
      
      protected var FMC_Blood_Fete:MovieClip = null;
      
      protected var FMC_Btn_AKeySwap:MovieClip = null;
      
      protected var FMC_Btn_Go_Get:MovieClip = null;
      
      protected var FCharacter:TCharacter;
      
      protected var FUIPage:TUIPage;
      
      protected var FHeroPageIndex:int;
      
      protected var FTabHeroIndex:int;
      
      protected var ThiNT:THint;
      
      protected var FCurrentRole:THero;
      
      protected var FInitializationSlots:Boolean;
      
      protected var FUITabHeros:TUITab;
      
      protected var FUIHero:TUIHero;
      
      protected var FCurHero:THero;
      
      protected var FNumenRoleCellMvc:Vector.<TNumenBagCellMvc> = null;
      
      protected var FNumenBagCellMvc:Vector.<TNumenBagCellMvc> = null;
      
      protected var FTempMouseBloodFete:TNumenBagCellMvc = null;
      
      protected var FBagBloodFeteCell:Vector.<TBagBloodFeteCell> = null;
      
      protected var FRoleBloodFeteCell:Vector.<TBagBloodFeteCell> = null;
      
      protected var FMC_BloodFete:MovieClip = null;
      
      protected var FMC_Ear_0:MovieClip = null;
      
      protected var FMC_Ear_1:MovieClip = null;
      
      protected var FTempMouseBloodFeteMouseCopy:TNumenBagCellMvc = null;
      
      protected var FTempMouseBloodFeteMouse:TNumenBagCellMvc = null;
      
      protected var FMC_MouseBloodFete:TMouseBloodFete = null;
      
      protected var FTUIWindowConfirmation:TUIWindowConfirmation = null;
      
      protected var FTUIWindowConfirmation2:TUIWindowConfirmation = null;
      
      protected var FTExpDecTip:TExpDecTip = null;
      
      protected var FTGoldCallBtn:TGoldCallBtn = null;
      
      protected var FTRealCellTip:TRealCellTip = null;
      
      protected var FBloodFeteData:TBloodFeteData = null;
      
      protected var FFieldOpenNum:int;
      
      protected var TCD:TCoordinate;
      
      protected var FCloseFunction:Function = null;
      
      protected var FCellMoveBackFun:Function = null;
      
      protected var FPhagocytosisBackFun:Function = null;
      
      protected var FBlood_FeteFunc:Function = null;
      
      protected var FBtn_AKeyFunc:Function = null;
      
      protected var FBtn_GoFunc:Function = null;
      
      protected var FOpenPackageCellBack:Function = null;
      
      protected var FPutOnCellOrTakeOffCell:Function;
      
      protected var FPiaoZi:Function;
      
      protected var FMouseStatus:int = 1;
      
      public function TProcessorWindowBloodFeteBag(param1:TUIComponent)
      {
         super(param1);
         this.FUIBloodPage = new TUIPage(this);
         this.FUIBloodPage.OnChangePage = this.BloodFeteBagChangePage;
         this.TCD = new TCoordinate();
         this.FUIPage = new TUIPage(this);
         this.FUITabHeros = new TUITab(this);
         this.FCharacter = SLogicsCore.Character;
         this.FBloodFeteData = SLogicsCore.BloodFeteDatas;
         this.FNumenRoleCellMvc = new Vector.<TNumenBagCellMvc>(C_SIX);
         this.FNumenBagCellMvc = new Vector.<TNumenBagCellMvc>(C_TWENTY);
         this.FBagBloodFeteCell = new Vector.<TBagBloodFeteCell>();
         this.FRoleBloodFeteCell = new Vector.<TBagBloodFeteCell>();
         this.ThiNT = new THint();
         this.FInitializationSlots = false;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_BLOODFETE.ResourceId);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.MainPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODFETE.MC_BloodFete_Bag) as Sprite;
         this.addChild(this.MainPanel);
         this.x = (FUICore.StageWidth - this.width) / 2;
         this.y = (FUICore.StageHeight - this.height) / 2;
         this.FUIBloodPage.ButtonNext.Substrate = this.MainPanel["MC_BloodPage"]["MC_PageRight"];
         this.FUIBloodPage.ButtonPrevious.Substrate = this.MainPanel["MC_BloodPage"]["MC_PageLeft"];
         this.FUIBloodPage.LabelPage = this.MainPanel["MC_BloodPage"]["TF_Page"];
         this.FUIBloodPage.PageSize = C_TWENTY;
         this.FUIBloodPage.TotalQuantity = 40;
         this.FUIBloodPage.Init();
         this.FUIBloodPage.Update();
         this.FMC_HeroPosition = this.MainPanel["MC_HeroPosition"] as Sprite;
         this.FMC_BloodFete = this.MainPanel["MC_MouseBloodFete"];
         this.FMC_Ear_0 = this.MainPanel["MC_Ear_0"];
         this.FMC_Ear_1 = this.MainPanel["MC_Ear_1"];
         this.FMC_MouseBloodFete = new TMouseBloodFete(this.FMC_BloodFete);
         this.FMC_MouseBloodFete.SetVisibel = false;
         this.FTF_FightingCapacity = this.MainPanel["TF_FightingCapacity"];
         this.FMC_Blood_Fete = this.MainPanel["MC_Blood_Fete"];
         this.FMC_Btn_AKeySwap = this.MainPanel["MC_Btn_AKeySwap"];
         this.FMC_Btn_Go_Get = this.MainPanel["MC_Btn_Go_Get"];
         TGameUtil.setButtonMode(this.FMC_Blood_Fete,true);
         TGameUtil.setButtonMode(this.FMC_Btn_AKeySwap,true);
         TGameUtil.setButtonMode(this.FMC_Btn_Go_Get,true);
         this.FUIHero = new TUIHero(this);
         this.FMC_HeroPosition.addChild(this.FUIHero);
         this.FUIHero.OnQuerySequenceContext = this.HeroOnQuerySequenceContext;
         this.FUIHero.DefaultRole = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_DefaultRoleTexture) as Sprite;
         _loc1_ = 0;
         while(_loc1_ < C_TEN)
         {
            _loc2_ = this.MainPanel["TF_HeroName_" + _loc1_];
            this.FUITabHeros.SetTabByIndex(_loc2_,_loc1_);
            this.FUITabHeros.SetTabCaptionByIndex("",_loc1_);
            _loc1_++;
         }
         this.FUITabHeros.OnSwitch = this.TabHerosOnSwitch;
         this.FUITabHeros.Init();
         this.FUIPage.ButtonPrevious.Substrate = this.MainPanel["MC_HeroPage"]["MC_PageLeft"];
         this.FUIPage.ButtonNext.Substrate = this.MainPanel["MC_HeroPage"]["MC_PageRight"];
         this.FUIPage.LabelPage = this.MainPanel["MC_HeroPage"]["TF_Page"];
         TextField(this.MainPanel["MC_HeroPage"]["TF_Page"]).text = "0/0";
         this.FUIPage.PageSize = C_TEN;
         this.FUIPage.Init();
         _loc1_ = 0;
         while(_loc1_ < C_SIX)
         {
            this.FNumenRoleCellMvc[_loc1_] = new TNumenBagCellMvc(this.MainPanel["MC_1_" + _loc1_]);
            this.FNumenRoleCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_OVER,this.PanelOver);
            this.FNumenRoleCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.PanelOut);
            this.FNumenRoleCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_DOWN,this.PanelOutDOWN);
            this.FNumenRoleCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_UP,this.PanelOutUP);
            this.FNumenRoleCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.NumenPanelMove);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < C_TWENTY)
         {
            this.FNumenBagCellMvc[_loc1_] = new TNumenBagCellMvc(this.MainPanel["MC_0_" + _loc1_]);
            this.FNumenBagCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_OVER,this.PanelOver);
            this.FNumenBagCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.PanelOut);
            this.FNumenBagCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_DOWN,this.PanelOutDOWN);
            this.FNumenBagCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_UP,this.PanelOutUP);
            this.FNumenBagCellMvc[_loc1_].ThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.NumenPanelMove);
            _loc1_++;
         }
         this.FTRealCellTip = new TRealCellTip(this);
         this.FTRealCellTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTRealCellTip);
         this.FTExpDecTip = new TExpDecTip(this);
         this.FTExpDecTip.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
         TUtilityUIOverlayer.ResourcesDispatch(this.FTExpDecTip);
         this.FTGoldCallBtn = new TGoldCallBtn(this);
         this.FTGoldCallBtn.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTGoldCallBtn);
         this.ConstructTyphonUIWindowInformation();
         this.ConstructTyphonUIWindowInformation2();
         this.FInitializationSlots = true;
         super.ResourcesPerform_UIDispatch();
      }
      
      public function NumenPanelMove(param1:MouseEvent) : void
      {
         this.TCD.X = mouseX;
         this.TCD.Y = mouseY;
         if(this.FTRealCellTip != null)
         {
            this.FTRealCellTip.Render(this.TCD);
            this.FTExpDecTip.Render(this.TCD);
            this.FTGoldCallBtn.Render(this.TCD);
         }
      }
      
      public function PanelOutDOWN(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         this.FMouseStatus = 0;
         var _loc3_:int = int(param1.currentTarget.name.split("_")[2]);
         if(param1.currentTarget.name.split("_")[1] == 1)
         {
            this.FMC_MouseBloodFete.NumenBagCellMvc = this.FNumenRoleCellMvc[_loc3_];
            this.FMC_MouseBloodFete.BeginOrEnd = 1;
            this.FTempMouseBloodFeteMouseCopy.BeginOrEnd = 1;
         }
         else
         {
            this.FMC_MouseBloodFete.NumenBagCellMvc = this.FNumenBagCellMvc[_loc3_];
            this.FMC_MouseBloodFete.BeginOrEnd = 0;
            this.FTempMouseBloodFeteMouseCopy.BeginOrEnd = 0;
            if(this.FMC_MouseBloodFete.NumenBagCellMvc.IsLocked)
            {
               _loc2_ = _loc3_ + this.FBloodPageIndex * C_TWENTY + 1 - this.FBloodFeteData.BagFieldLocked;
               this.FFieldOpenNum = _loc2_;
               this.FTUIWindowConfirmation.Text = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Function_Cost_Open_Cell,this.GetCost(_loc2_),_loc2_);
               this.FTUIWindowConfirmation.visible = true;
            }
         }
         if(!this.FMC_MouseBloodFete.NumenBagCellMvc.ThisCellHave)
         {
            return;
         }
         this.SetDartBegin();
      }
      
      public function GetCost(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = this.FBloodFeteData.BagFieldLocked - this.FBloodFeteData.BagCellOpened;
         while(param1)
         {
            param1--;
            _loc2_ += this.FBloodFeteData.BagCost_ByCount[param1 + _loc3_];
         }
         return _loc2_;
      }
      
      public function PanelOutUP(param1:MouseEvent) : void
      {
         this.SetDartStop();
         this.ReflashS_COnely();
      }
      
      protected function PanelOver(param1:MouseEvent) : void
      {
         var _loc2_:int = mouseX;
         var _loc3_:int = mouseY;
         this.ForConcise(param1.currentTarget);
         MovieClip(param1.currentTarget)["MC_Effect"].gotoAndStop(1);
      }
      
      protected function PanelOut(param1:MouseEvent) : void
      {
         this.FTempMouseBloodFeteMouseCopy = this.FTempMouseBloodFeteMouse;
         this.FTempMouseBloodFeteMouse = null;
         if(this.FTRealCellTip != null)
         {
            this.FTRealCellTip.Hide();
            this.FTExpDecTip.Hide();
            this.FTGoldCallBtn.Hide();
         }
         MovieClip(param1.currentTarget)["MC_Effect"].gotoAndStop(2);
      }
      
      protected function ForConcise(param1:Object) : void
      {
         this.TCD.X = mouseX;
         this.TCD.Y = mouseY;
         var _loc2_:int = int(param1.name.split("_")[1]);
         var _loc3_:int = int(param1.name.split("_")[2]);
         if(_loc2_)
         {
            this.FTempMouseBloodFeteMouse = this.FNumenRoleCellMvc[_loc3_];
            this.FTempMouseBloodFeteMouse.IsBagOrHero = 1;
            this.FTempMouseBloodFeteMouse.CurentIndex = _loc3_;
         }
         else
         {
            this.FTempMouseBloodFeteMouse = this.FNumenBagCellMvc[_loc3_];
            this.FTempMouseBloodFeteMouse.IsBagOrHero = 0;
            this.FTempMouseBloodFeteMouse.CurentIndex = _loc3_ + this.FBloodPageIndex * C_TWENTY;
         }
         if(!this.FTempMouseBloodFeteMouse.IsLocked)
         {
            if(this.FTempMouseBloodFeteMouse.ThisCellHave)
            {
               if(this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.Type == 3)
               {
                  if(this.FTGoldCallBtn != null)
                  {
                     this.ThiNT.Content = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_CallBtnTipHtml_Exp,this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.Name,this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.DevourExp);
                     this.FTGoldCallBtn.Context = this.ThiNT;
                     this.FTGoldCallBtn.Render(this.TCD);
                     this.FTGoldCallBtn.Show();
                  }
               }
               else if(this.FTRealCellTip != null)
               {
                  this.FTRealCellTip.Context = this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle;
                  this.FTRealCellTip.Render(this.TCD);
                  this.FTRealCellTip.Show();
               }
            }
         }
         else if(_loc2_)
         {
            this.FTExpDecTip.Context = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_Level_DecTip,STRING_COMMON.GetLevelStrByLevelLineFeed(this.FBloodFeteData.BodyLevel_OpenCount[_loc3_]));
            this.FTExpDecTip.Render(this.TCD);
            this.FTExpDecTip.Show();
         }
         this.FTempMouseBloodFeteMouseCopy = this.FTempMouseBloodFeteMouse;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.OpenPanel();
         this.AddEventlistener();
         this.FUIPage.OnChangePage = this.HeroPageOnChange;
         super.ResourcesPerform_UILocations();
      }
      
      protected function AddEventlistener() : void
      {
         SimpleButton(this.MainPanel[CONST_BLOODFETE.MC_Close]).addEventListener(MouseEvent.CLICK,this.CloseBtn);
         this.addEventListener(MouseEvent.MOUSE_OVER,this.Panel_Over);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.Panel_Out);
         Parent.addEventListener(MouseEvent.MOUSE_MOVE,this.PanelMove);
         this.addEventListener(MouseEvent.MOUSE_UP,this.PanelMoveUP);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.PanelDown);
         this.FMC_Blood_Fete.addEventListener(MouseEvent.CLICK,this.FMC_Blood_Click);
         this.FMC_Btn_AKeySwap.addEventListener(MouseEvent.CLICK,this.FMC_Blood_Click);
         this.FMC_Btn_Go_Get.addEventListener(MouseEvent.CLICK,this.FMC_Blood_Click);
      }
      
      protected function FMC_Blood_Click(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FMC_Blood_Fete:
               if(this.FBlood_FeteFunc != null)
               {
                  this.FBlood_FeteFunc();
               }
               break;
            case this.FMC_Btn_AKeySwap:
               if(this.FBtn_AKeyFunc != null)
               {
                  this.FBtn_AKeyFunc();
               }
               break;
            case this.FMC_Btn_Go_Get:
               if(this.FBtn_GoFunc != null)
               {
                  this.FBtn_GoFunc();
               }
         }
      }
      
      public function PanelDown(param1:MouseEvent) : void
      {
         if(this.FMouseStatus)
         {
            Sprite(param1.currentTarget).startDrag();
         }
      }
      
      public function PanelMoveUP(param1:MouseEvent) : void
      {
         Sprite(param1.currentTarget).stopDrag();
         this.SetDartStop();
         this.FMouseStatus = 1;
         this.ReflashS_COnely();
      }
      
      public function UpdateHeroUIPage() : void
      {
         this.FUIPage.TotalQuantity = this.FCharacter.Heros.Count;
         this.FUIPage.PageIndex = this.FHeroPageIndex;
         this.FUIPage.Update();
      }
      
      public function PanelMove(param1:MouseEvent) : void
      {
         if(this.FMC_MouseBloodFete.IsFollowMouse)
         {
            this.FMC_BloodFete.x = mouseX - this.FMC_BloodFete.width / 2;
            this.FMC_BloodFete.y = mouseY - this.FMC_BloodFete.height / 2;
         }
      }
      
      public function Panel_Over(param1:MouseEvent) : void
      {
      }
      
      public function Panel_Out(param1:MouseEvent) : void
      {
      }
      
      public function SetDartStop() : void
      {
         var _loc1_:TBloodFeteSingle = null;
         var _loc2_:TBloodFeteSingle = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         if(this.FMC_MouseBloodFete.SetVisibel)
         {
            this.FMC_MouseBloodFete.IsFollowMouse = false;
            this.FMC_MouseBloodFete.SetVisibel = false;
            if(this.FTempMouseBloodFeteMouse != null)
            {
               if(!this.FTempMouseBloodFeteMouse.IsLocked)
               {
                  if(!this.FTempMouseBloodFeteMouse.ThisCellHave)
                  {
                     this.FTempMouseBloodFeteMouse.BagBloodFeteCell = this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell;
                     this.FMC_MouseBloodFete.NumenBagCellMvc.ThisCellHave = false;
                     if(this.FMC_MouseBloodFete.BeginOrEnd == 0)
                     {
                        if(this.FTempMouseBloodFeteMouse.IsBagOrHero == 1)
                        {
                           if(this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.Type == 3)
                           {
                              this.FPiaoZi(STRING_FETEBLOODMAINMANAGE.Tip_4);
                              this.BackMouseHome();
                              return;
                           }
                           if(this.FPutOnCellOrTakeOffCell != null)
                           {
                              this.FPutOnCellOrTakeOffCell(this.FTempMouseBloodFeteMouse.IsBagOrHero,this.FTempMouseBloodFeteMouse.CurentIndex,this.FTempMouseBloodFeteMouse.BagBloodFeteCell,this.FCurrentRole);
                           }
                        }
                        else
                        {
                           this.MoveMerge();
                        }
                     }
                     else if(this.FTempMouseBloodFeteMouse.IsBagOrHero == 1)
                     {
                        this.MoveMerge();
                     }
                     else if(this.FPutOnCellOrTakeOffCell != null)
                     {
                        this.FPutOnCellOrTakeOffCell(this.FTempMouseBloodFeteMouse.IsBagOrHero,this.FTempMouseBloodFeteMouse.CurentIndex,this.FTempMouseBloodFeteMouse.BagBloodFeteCell,this.FCurrentRole);
                     }
                     this.ClearMouseBloodFete();
                     return;
                  }
                  if(this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell == null)
                  {
                     return;
                  }
                  if(this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle.IdentifierUInt64.High == this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.IdentifierUInt64.High)
                  {
                     if(this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle.IdentifierUInt64.Low == this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.IdentifierUInt64.Low)
                     {
                        this.BackMouseHome_Copy();
                        return;
                     }
                  }
                  if(this.FTUIWindowConfirmation2.visible)
                  {
                     return;
                  }
                  _loc6_ = 0;
                  _loc1_ = this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle;
                  _loc2_ = this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle;
                  if(this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle.Type == 3)
                  {
                     if(this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.Type == 3)
                     {
                        this.FPiaoZi(STRING_FETEBLOODMAINMANAGE.DOntTip);
                        this.BackMouseHome_Copy();
                        return;
                     }
                     _loc1_ = this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle;
                     _loc2_ = this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle;
                     _loc7_ = 1;
                  }
                  else if(this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.Type == 3)
                  {
                     _loc7_ = 1;
                  }
                  if(!_loc7_)
                  {
                     if(this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle.Quality <= this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.Quality)
                     {
                        if(this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle.Quality == this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.Quality)
                        {
                           _loc3_ = this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle.Exp;
                           _loc4_ = this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle.Exp;
                           if(_loc3_ == _loc4_)
                           {
                              _loc1_ = this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle;
                              _loc2_ = this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle;
                           }
                           else if(_loc3_ <= _loc4_)
                           {
                              _loc1_ = this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle;
                              _loc2_ = this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle;
                           }
                        }
                        else
                        {
                           _loc1_ = this.FTempMouseBloodFeteMouse.BagBloodFeteCell.BloodFeteSingle;
                           _loc2_ = this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell.BloodFeteSingle;
                        }
                     }
                  }
                  if(_loc1_.Level >= 15)
                  {
                     this.FPiaoZi(STRING_FETEBLOODMAINMANAGE.DOntTipManLevel);
                     this.BackMouseHome_Copy();
                     return;
                  }
                  if(_loc1_.Exp + _loc2_.DevourExp + _loc2_.Exp >= _loc1_.AllExp)
                  {
                     _loc6_ = this.GetCanUpLevel(_loc1_,_loc2_.DevourExp + _loc2_.Exp);
                     this.FTUIWindowConfirmation2.SetHtml = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_EatDecHtml_2,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc1_.Quality],_loc1_.Name,_loc2_.Type == 3 ? CONST_COMMON.QUALITYCOLOR_INDEX_1[6] : CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc2_.Quality],_loc2_.Name,_loc2_.DevourExp + _loc2_.Exp,_loc1_.Name,_loc6_ + _loc1_.Level);
                  }
                  else
                  {
                     this.FTUIWindowConfirmation2.SetHtml = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.STRING_EatDecHtml,CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc1_.Quality],_loc1_.Name,_loc2_.Type == 3 ? CONST_COMMON.QUALITYCOLOR_INDEX_1[6] : CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc2_.Quality],_loc2_.Name,_loc2_.DevourExp + _loc2_.Exp);
                  }
                  this.FTUIWindowConfirmation2.visible = true;
               }
            }
         }
      }
      
      protected function GetCanUpLevel(param1:TBloodFeteSingle, param2:int) : int
      {
         var _loc4_:TFollowBloodBound = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _loc5_ = int(param1.NextLevelID);
         var _loc6_:int = param1.Exp + param2;
         var _loc7_:int = int(param1.AllExp);
         while(_loc6_ >= _loc7_)
         {
            if(_loc5_ == 0)
            {
               break;
            }
            _loc3_++;
            _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_FollowBloodBound,_loc5_) as TFollowBloodBound;
            _loc5_ = _loc4_.NextLevelID;
            _loc7_ = _loc4_.ExpAll;
         }
         return _loc3_;
      }
      
      public function MoveMerge() : void
      {
         if(!this.FTempMouseBloodFeteMouse.BagBloodFeteCell)
         {
            this.BackMouseHome();
            return;
         }
         this.FCellMoveBackFun(this.FTempMouseBloodFeteMouse.IsBagOrHero,this.FTempMouseBloodFeteMouse.CurentIndex,this.FTempMouseBloodFeteMouse.BagBloodFeteCell,this.FCurrentRole);
      }
      
      public function WindowTyphonInformationOnOK2(param1:Object) : void
      {
         this.FMC_MouseBloodFete.SetVisibel = false;
         this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell = this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell;
         var _loc2_:int = 0;
         if(this.FMC_MouseBloodFete.BeginOrEnd)
         {
            _loc2_ = 1;
         }
         else if(this.FTempMouseBloodFeteMouseCopy.IsBagOrHero)
         {
            _loc2_ = 1;
         }
         else
         {
            _loc2_ = 0;
         }
         this.FPhagocytosisBackFun(_loc2_,this.FTempMouseBloodFeteMouseCopy.CurentIndex,this.FMC_MouseBloodFete.NumenBagCellMvc.BagBloodFeteCell,this.FTempMouseBloodFeteMouseCopy.BagBloodFeteCell,this.FCurrentRole);
         this.BackMouseHome();
      }
      
      public function WindowTyphonInformationOnCancel2(param1:Object) : void
      {
         this.BackMouseHome();
      }
      
      public function BackMouseHome_Copy() : void
      {
         this.FTempMouseBloodFeteMouse = null;
      }
      
      public function BackMouseHome() : void
      {
         this.PhagocytosisBack();
      }
      
      public function PhagocytosisBack() : void
      {
         if(this.FTempMouseBloodFeteMouse)
         {
            if(this.FTempMouseBloodFeteMouse.BagBloodFeteCell)
            {
               this.FTempMouseBloodFeteMouse.BagBloodFeteCell = null;
            }
         }
         this.FTempMouseBloodFeteMouse = null;
      }
      
      public function ClearMouseBloodFete() : void
      {
         this.FMC_MouseBloodFete.IsFollowMouse = false;
         this.FMC_MouseBloodFete.SetVisibel = false;
         this.FMC_MouseBloodFete.NumenBagCellMvc = null;
      }
      
      public function WindowTyphonInformationOnOK(param1:Object) : void
      {
         if(this.FOpenPackageCellBack != null)
         {
            this.FOpenPackageCellBack(this.FFieldOpenNum);
         }
      }
      
      public function SetDartBegin() : void
      {
         this.FMC_BloodFete.x = mouseX - this.FMC_BloodFete.width / 2;
         this.FMC_BloodFete.y = mouseY - this.FMC_BloodFete.height / 2;
         this.FMC_MouseBloodFete.IsFollowMouse = true;
         this.FMC_MouseBloodFete.SetVisibel = true;
      }
      
      protected function TabHerosOnSwitch(param1:Object) : void
      {
         this.FTabHeroIndex = param1 as int;
         this.FTabHeroIndex += this.FHeroPageIndex * C_TEN;
         this.UpdateRoleModel();
         this.UpdateBloodFeteInfo();
      }
      
      protected function HeroPageOnChange(param1:Object, param2:int) : void
      {
         this.FHeroPageIndex = param2;
         this.FTabHeroIndex = 0;
         this.FTabHeroIndex += this.FHeroPageIndex * C_TEN;
         this.UpdateTabs();
         this.TabHerosOnSwitch(this);
         this.FUITabHeros.SwithTagManual(0);
         this.UpdateTabsProportion();
      }
      
      protected function UpdateRoleModel() : void
      {
         if(this.FCharacter.Heros.Count <= this.FTabHeroIndex)
         {
            this.FTabHeroIndex = 0;
         }
         this.FCurrentRole = this.FCharacter.Heros.GetHeroByIndex(this.FTabHeroIndex);
         this.ReflashRoleCell();
         this.ReflashRoleBagCellDate();
         this.FUIHero.Context = this.FCurrentRole;
         this.FCurHero = this.FCurrentRole;
         this.UpdateRoleCell();
      }
      
      protected function UpdateRoleCell() : void
      {
         var _loc1_:int = 0;
         this.FRoleBloodFeteCell.length = 0;
         var _loc2_:TBagBloodFeteCell = null;
         _loc1_ = 0;
         while(_loc1_ < this.FCurrentRole.BloodFeteMounted.length)
         {
            _loc2_ = new TBagBloodFeteCell();
            _loc2_.BloodFeteSingle = null;
            _loc2_.BloodFeteSingle = this.FCurrentRole.BloodFeteMounted[_loc1_];
            this.FRoleBloodFeteCell.push(_loc2_);
            _loc1_++;
         }
         _loc2_ = null;
         _loc1_ = 0;
         while(_loc1_ < this.FRoleBloodFeteCell.length)
         {
            this.FNumenRoleCellMvc[this.FRoleBloodFeteCell[_loc1_].BloodFeteSingle.PositionIndex].BagBloodFeteCell = this.FRoleBloodFeteCell[_loc1_];
            _loc1_++;
         }
      }
      
      protected function UpdateBagCell() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FBagBloodFeteCell.length = 0;
         var _loc3_:TBagBloodFeteCell = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBloodFeteData.RealBagBloodFete.length)
         {
            _loc3_ = new TBagBloodFeteCell();
            _loc3_.BloodFeteSingle = null;
            _loc3_.BloodFeteSingle = this.FBloodFeteData.RealBagBloodFete[_loc1_];
            this.FBagBloodFeteCell.push(_loc3_);
            _loc1_++;
         }
         _loc3_ = null;
         _loc1_ = 0;
         while(_loc1_ < this.FBagBloodFeteCell.length)
         {
            _loc2_ = this.FBagBloodFeteCell[_loc1_].BloodFeteSingle.PositionIndex;
            if(_loc2_ >= this.FBloodPageIndex * C_TWENTY && _loc2_ < (this.FBloodPageIndex + 1) * C_TWENTY)
            {
               this.FNumenBagCellMvc[_loc2_ % C_TWENTY].BagBloodFeteCell = this.FBagBloodFeteCell[_loc1_];
            }
            _loc1_++;
         }
      }
      
      public function OpenPanel() : void
      {
         if(!this.FInitializationSlots)
         {
            return;
         }
         this.UpdateTabs();
         this.UpdateOpenPanel();
         this.UpdateBloodFeteInfo();
         if(this.FMC_Ear_0 != null)
         {
            this.FMC_Ear_0.gotoAndPlay(1);
            this.FMC_Ear_1.gotoAndPlay(1);
         }
         this.UpdateTabsProportion();
      }
      
      public function UpdateOpenPanel() : void
      {
         this.UpdateCellCount();
         this.PhagocytosisBack();
         this.ReflashRoleCell();
         this.ReflashBagCell();
         this.ReflashBagCellDate();
         this.UpdateRoleCell();
         this.UpdateBagCell();
      }
      
      public function UpdateCellCount() : void
      {
         this.FTF_FightingCapacity.text = String(this.FBloodFeteData.DebrisNum);
      }
      
      public function UpdateBloodFeteInfo() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBagBloodFeteCell = null;
         var _loc5_:String = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         _loc2_ = 0;
         _loc1_ = 0;
         while(_loc1_ < C_SIX)
         {
            while(_loc2_ < C_SIX)
            {
               _loc4_ = this.FNumenRoleCellMvc[_loc2_].BagBloodFeteCell;
               if(_loc4_)
               {
                  _loc2_++;
                  break;
               }
               _loc2_++;
            }
            if(_loc4_)
            {
               this.MainPanel["TF_name_" + _loc1_].text = _loc4_.BloodFeteSingle.Name;
               _loc5_ = "";
               _loc3_ = 0;
               while(_loc3_ < _loc4_.BloodFeteSingle.AddAttrArr.length)
               {
                  _loc6_ = _loc4_.BloodFeteSingle.AddAttrArr[_loc3_];
                  _loc5_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc6_[0])] + " +" + this.getProptyScr(_loc6_);
                  _loc3_++;
               }
               _loc7_ = STRING_COMMON.FORMAT_Level + _loc4_.BloodFeteSingle.Level + "\t" + "<font color=\'" + CONST_COMMON.QUALITYCOLOR_INDEX_1[_loc4_.BloodFeteSingle.Quality] + "\'>" + _loc5_ + "</font>";
               this.MainPanel["TF_value_" + _loc1_].htmlText = _loc7_;
            }
            else
            {
               this.MainPanel["TF_name_" + _loc1_].text = STRING_COMMON.COMMON_NONE;
               this.MainPanel["TF_value_" + _loc1_].text = STRING_COMMON.COMMON_NONE;
            }
            _loc4_ = null;
            _loc1_++;
         }
      }
      
      public function getProptyScr(param1:Array) : String
      {
         var _loc2_:String = null;
         if(int(param1[1]) != param1[1])
         {
            _loc2_ = Number(param1[1] * 100).toFixed(1) + "%";
         }
         else
         {
            _loc2_ = String(param1[1]);
         }
         return _loc2_;
      }
      
      public function ReflashS_COnely() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.ReflashBagCellDate();
         this.UpdateRoleCell();
         this.UpdateBagCell();
         this.UpdateCellCount();
         this.UpdateHeroUIPage();
         this.UpdateTabsProportion();
         this.UpdateBloodFeteInfo();
      }
      
      public function ReflashBagCell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < C_TWENTY)
         {
            if(_loc1_ + this.FBloodPageIndex * C_TWENTY < this.FBloodFeteData.BagFieldLocked)
            {
               this.FNumenBagCellMvc[_loc1_].IsLocked = false;
            }
            else
            {
               this.FNumenBagCellMvc[_loc1_].IsLocked = true;
            }
            _loc1_++;
         }
      }
      
      public function ReflashBagCellDate() : void
      {
         var _loc1_:int = 0;
         this.ReflashRoleBagCellDate();
         _loc1_ = 0;
         while(_loc1_ < C_TWENTY)
         {
            this.FNumenBagCellMvc[_loc1_].BagBloodFeteCell = null;
            _loc1_++;
         }
      }
      
      public function ReflashRoleBagCellDate() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < C_SIX)
         {
            this.FNumenRoleCellMvc[_loc1_].BagBloodFeteCell = null;
            _loc1_++;
         }
      }
      
      protected function BloodFeteBagChangePage(param1:Object, param2:int) : void
      {
         this.FBloodPageIndex = param2;
         this.PhagocytosisBack();
         this.ReflashBagCell();
         this.ReflashBagCellDate();
         this.UpdateBagCell();
      }
      
      protected function GetCountByHero(param1:THero) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < C_SIX)
         {
            if(this.GetBoolean(param1,_loc3_))
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function GetBoolean(param1:THero, param2:int) : Boolean
      {
         return Boolean(param1.Level >= this.FBloodFeteData.BodyLevel_OpenCount[param2]);
      }
      
      public function ReflashRoleCell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < C_SIX)
         {
            if(this.GetBoolean(this.FCurrentRole,_loc1_))
            {
               this.FNumenRoleCellMvc[_loc1_].IsLocked = false;
            }
            else
            {
               this.FNumenRoleCellMvc[_loc1_].IsLocked = true;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTabsProportion() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THeros = null;
         var _loc4_:THero = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:TextField = null;
         _loc3_ = this.FCharacter.Heros;
         _loc3_.Sort();
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < C_TEN)
         {
            _loc6_ = _loc1_ + this.FHeroPageIndex * C_TEN;
            _loc7_ = this.FUITabHeros.GetMoviClipByIndex(_loc1_)["TF_Proportion"];
            if(_loc6_ >= _loc2_)
            {
               if(_loc7_)
               {
                  _loc7_.visible = false;
               }
            }
            else
            {
               _loc4_ = _loc3_.GetHeroByIndex(_loc6_);
               if(_loc7_)
               {
                  _loc7_.visible = true;
                  _loc7_.text = TUtilityString.Format(STRING_FETEBLOODMAINMANAGE.Tip_5,_loc4_.BloodFeteMounted.length,this.GetCountByHero(_loc4_));
                  _loc7_.textColor = 4288282470;
               }
            }
            _loc1_++;
         }
      }
      
      protected function UpdateTabs() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:THeros = null;
         var _loc4_:THero = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         _loc3_ = this.FCharacter.Heros;
         _loc3_.Sort();
         _loc2_ = _loc3_.Count;
         _loc1_ = 0;
         while(_loc1_ < C_TEN)
         {
            _loc6_ = _loc1_ + this.FHeroPageIndex * C_TEN;
            if(_loc6_ >= _loc2_)
            {
               this.FUITabHeros.SetTabHideByIndex(_loc1_);
            }
            else
            {
               _loc4_ = _loc3_.GetHeroByIndex(_loc6_);
               _loc5_ = QUALITYCOLOR_INDEX[_loc4_.Quality];
               this.FUITabHeros.SetTabCaptionByIndex(_loc4_.Name,_loc1_,_loc5_);
               this.FUITabHeros.SetTabShowByIndex(_loc1_);
            }
            _loc1_++;
         }
         this.UpdateRoleModel();
      }
      
      protected function HeroOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:THero = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         var _loc8_:TBounds = null;
         var _loc9_:TCoordinate = null;
         var _loc10_:TRoleModel = null;
         _loc5_ = param2 as THero;
         _loc8_ = new TBounds();
         _loc9_ = new TCoordinate();
         _loc6_ = SResourcesCore.TexturesModel;
         _loc10_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_RoleModel,_loc5_.Identifier) as TRoleModel;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc10_.Model);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIndex(0);
            param3.Value.Evaluate(_loc9_,_loc8_);
            this.FUIHero.X = _loc8_.X;
            this.FUIHero.Y = _loc8_.Y;
         }
         else
         {
            _loc6_.LoadSecondary(_loc10_.Model,CONST_MODULES.MODULE_BloodFete);
            this.FUIHero.X = 0;
            this.FUIHero.Y = 0;
         }
      }
      
      protected function ConstructTyphonUIWindowInformation2() : void
      {
         this.FTUIWindowConfirmation2 = new TUIWindowConfirmation(this.Parent);
         this.FTUIWindowConfirmation2.OnOK = this.WindowTyphonInformationOnOK2;
         this.FTUIWindowConfirmation2.OnCancel = this.WindowTyphonInformationOnCancel2;
         this.FTUIWindowConfirmation2.x = (FUICore.StageWidth - this.FTUIWindowConfirmation2.WindowWidth) / 2;
         this.FTUIWindowConfirmation2.y = (FUICore.StageHeight - this.FTUIWindowConfirmation2.WindowHeight) / 2 - 30;
         TUtilityUIWindow.SetupWindowConfirmation(this.FTUIWindowConfirmation2);
      }
      
      protected function ConstructTyphonUIWindowInformation() : void
      {
         this.FTUIWindowConfirmation = new TUIWindowConfirmation(this.Parent);
         this.FTUIWindowConfirmation.OnOK = this.WindowTyphonInformationOnOK;
         this.FTUIWindowConfirmation.x = (FUICore.StageWidth - this.FTUIWindowConfirmation.WindowWidth) / 2;
         this.FTUIWindowConfirmation.y = (FUICore.StageHeight - this.FTUIWindowConfirmation.WindowHeight) / 2 - 30;
         TUtilityUIWindow.SetupWindowConfirmation(this.FTUIWindowConfirmation);
      }
      
      public function LogicPerform() : void
      {
         if(!this.FInitializationSlots)
         {
            return;
         }
         if(!Visible)
         {
            return;
         }
         this.FUIHero.Update();
         this.UpdateImage();
      }
      
      protected function UpdateImage() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FRoleBloodFeteCell.length)
         {
            this.FRoleBloodFeteCell[_loc1_].UpdateImage();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FBagBloodFeteCell.length)
         {
            this.FBagBloodFeteCell[_loc1_].UpdateImage();
            _loc1_++;
         }
      }
      
      protected function CloseBtn(param1:MouseEvent) : void
      {
         if(this.FCloseFunction != null)
         {
            this.FCloseFunction(2);
         }
      }
      
      public function set CloseFunction(param1:Function) : void
      {
         this.FCloseFunction = param1;
      }
      
      public function get CloseFunction() : Function
      {
         return this.FCloseFunction;
      }
      
      public function set CellMoveBackFun(param1:Function) : void
      {
         this.FCellMoveBackFun = param1;
      }
      
      public function set PhagocytosisBackFun(param1:Function) : void
      {
         this.FPhagocytosisBackFun = param1;
      }
      
      public function set Blood_FeteFunc(param1:Function) : void
      {
         this.FBlood_FeteFunc = param1;
      }
      
      public function set Btn_AKeyFunc(param1:Function) : void
      {
         this.FBtn_AKeyFunc = param1;
      }
      
      public function set Btn_GoFunc(param1:Function) : void
      {
         this.FBtn_GoFunc = param1;
      }
      
      public function set OpenPackageCellBack(param1:Function) : void
      {
         this.FOpenPackageCellBack = param1;
      }
      
      public function set PutOnCellOrTakeOffCell(param1:Function) : void
      {
         this.FPutOnCellOrTakeOffCell = param1;
      }
      
      public function set PiaoZi(param1:Function) : void
      {
         this.FPiaoZi = param1;
      }
   }
}

