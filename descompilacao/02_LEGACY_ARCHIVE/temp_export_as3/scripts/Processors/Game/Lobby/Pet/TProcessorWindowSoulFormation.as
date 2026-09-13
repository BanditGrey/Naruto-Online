package Processors.Game.Lobby.Pet
{
   import Components.Pages.TUIPage;
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TSoulArray;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.TBaseActivity;
   import Logics.Pet.TPet;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Rendering.Overlayers.Pet.TOverlayerSoulFormationSkill;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_PET;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import ghostcat.util.data.Json;
   
   public class TProcessorWindowSoulFormation extends TProcessorLobbyWindow
   {
      
      public static const TAB_COUNT:uint = 4;
      
      public static const TAB_ALL:int = 0;
      
      public static const TAB_TYPE_1:int = 1;
      
      public static const TAB_TYPE_2:int = 2;
      
      public static const TAB_TYPE_3:int = 3;
      
      public static const ITEM_COUNT:uint = 3;
      
      public static const FORWARD_COUNT:uint = 4;
      
      public static const MIDDLE_COUNT:uint = 3;
      
      public static const BACK_COUNT:uint = 2;
      
      public static const REQ_OF_ACTIVE:int = 1;
      
      public static const REQ_OF_OPEN:int = 2;
      
      public static const REQ_OF_CANCEL:int = 3;
      
      public static const MAX_LEVEL:int = 40;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FPet:TPet;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FUIPage:TUIPage;
      
      protected var FTotalPage:int;
      
      protected var FCurPage:int;
      
      protected var FHelpTips:THint;
      
      protected var FCurInfo:Vector.<TSoulArray>;
      
      protected var FOverlayerSoulFormationSkill:TOverlayerSoulFormationSkill;
      
      public var OnGetBox:Function;
      
      public var OnBuyBox:Function;
      
      public var OnShowHtmlTip:Function;
      
      public var OnHideHtmlTip:Function;
      
      public var GotoAddSoul:Function;
      
      public function TProcessorWindowSoulFormation(param1:TUIComponent)
      {
         super(param1);
         this.FPet = SLogicsCore.Character.Pet;
         this.FUITab = new TUITab(this);
         this.FHelpTips = new THint();
         this.FCurInfo = new Vector.<TSoulArray>();
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_PET.RESOURCESID_PET);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_SoulFormation") as MovieClip;
         addChild(this.FMC_Scene);
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc2_ = this.FMC_Scene["MC_Item" + _loc1_];
            _loc2_.MC_Info.MC_PackUp.MC_Effect.mouseEnabled = false;
            _loc2_.MC_Info.MC_PackUp.MC_Effect.mouseChildren = false;
            _loc2_.MC_Info.MC_Spread.MC_Effect.mouseEnabled = false;
            _loc2_.MC_Info.MC_Spread.MC_Effect.mouseChildren = false;
            TGameUtil.setButtonMode(_loc2_.BTN_Cancel,true);
            TGameUtil.setButtonMode(_loc2_.BTN_Open,true);
            TGameUtil.setButtonMode(_loc2_.BTN_Add,true);
            TGameUtil.setButtonMode(_loc2_.BTN_Active,true);
            _loc2_.BTN_Cancel.addEventListener(MouseEvent.CLICK,this.ProcessorOnCancelUp);
            _loc2_.BTN_Open.addEventListener(MouseEvent.CLICK,this.ProcessorOnOpenUp);
            _loc2_.BTN_Add.addEventListener(MouseEvent.CLICK,this.ProcessorOnAddUp);
            _loc2_.BTN_Active.addEventListener(MouseEvent.CLICK,this.ProcessorOnActiveUp);
            _loc2_.MC_Info.MC_PackUp.visible = false;
            _loc2_.MC_Info.MC_PackUp.buttonMode = true;
            _loc2_.MC_Info.MC_PackUp.addEventListener(MouseEvent.CLICK,this.ProcessorOnPackUp);
            _loc2_.MC_Info.MC_Spread.buttonMode = true;
            _loc2_.MC_Info.MC_Spread.addEventListener(MouseEvent.CLICK,this.ProcessorOnSpreadUp);
            _loc2_.MC_SkillTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProceossorOnSkillOver);
            _loc2_.MC_SkillTip.addEventListener(MouseEvent.ROLL_OUT,this.ProceossorOnSkillOut);
            _loc2_.MC_MaxSkill.addEventListener(MouseEvent.MOUSE_MOVE,this.ProceossorOnMaxSkillOver);
            _loc2_.MC_MaxSkill.addEventListener(MouseEvent.ROLL_OUT,this.ProceossorOnSkillOut);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(this.FMC_Scene["BTN_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FUIPage = new TUIPage(this);
         this.FUIPage.ButtonPrevious.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageLeft;
         this.FUIPage.ButtonNext.Substrate = this.FMC_Scene.MC_ChangePage.MC_PageRight;
         this.FUIPage.LabelPage = this.FMC_Scene.MC_ChangePage.TF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = ITEM_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
         this.FOverlayerSoulFormationSkill = new TOverlayerSoulFormationSkill(this.Parent);
         this.FOverlayerSoulFormationSkill.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSoulFormationSkill);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         var _loc1_:uint = 0;
         super.LogicsPerform();
         if(!FIsResourcesLoadCompleted || !Visible)
         {
            return;
         }
         if(Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
         }
      }
      
      protected function UpdateItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:TSoulArray = null;
         var _loc6_:String = null;
         this.FUIPage.TotalQuantity = this.FCurInfo.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < ITEM_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * ITEM_COUNT;
            _loc3_ = this.FMC_Scene["MC_Item" + _loc1_];
            if(_loc2_ < this.FCurInfo.length)
            {
               _loc3_.visible = true;
               _loc5_ = this.FCurInfo[_loc2_];
               if(_loc5_.Status == TBaseActivity.STATUS_IS_GOT)
               {
                  _loc3_.BTN_Cancel.visible = true;
                  _loc3_.BTN_Open.visible = false;
                  _loc3_.BTN_Add.visible = true;
                  _loc3_.BTN_Active.visible = false;
                  _loc3_.MC_Avtived.visible = true;
                  _loc3_.TF_Active.text = "";
                  _loc3_.gotoAndStop(1);
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_GETED)
               {
                  _loc3_.BTN_Cancel.visible = false;
                  _loc3_.BTN_Open.visible = true;
                  _loc3_.BTN_Add.visible = true;
                  _loc3_.BTN_Active.visible = false;
                  _loc3_.MC_Avtived.visible = false;
                  _loc3_.TF_Active.text = "";
                  _loc3_.gotoAndStop(1);
               }
               else if(_loc5_.Status == TBaseActivity.STATUS_CANGET)
               {
                  _loc3_.BTN_Cancel.visible = false;
                  _loc3_.BTN_Open.visible = false;
                  _loc3_.BTN_Add.visible = false;
                  _loc3_.BTN_Active.visible = true;
                  TGameUtil.setButtonMode(_loc3_.BTN_Active,true);
                  _loc3_.MC_Avtived.visible = false;
                  _loc3_.TF_Active.text = _loc5_.OpenCondition;
                  _loc3_.gotoAndStop(2);
               }
               else
               {
                  _loc3_.BTN_Cancel.visible = false;
                  _loc3_.BTN_Open.visible = false;
                  _loc3_.BTN_Add.visible = false;
                  _loc3_.BTN_Active.visible = true;
                  TGameUtil.setButtonMode(_loc3_.BTN_Active,false);
                  _loc3_.MC_Avtived.visible = false;
                  _loc3_.TF_Active.text = _loc5_.OpenCondition;
                  _loc3_.gotoAndStop(2);
               }
               _loc3_.TF_Name.text = _loc5_.name;
               _loc3_.TF_Type.text = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70101023 + _loc5_.type - 1) as TSystemLanguage).Desc;
               _loc3_.TF_Skill.text = _loc5_.SkillName;
               _loc3_.TF_Level.text = _loc5_.level;
               _loc3_.MC_Pic.gotoAndStop(_loc5_.resource);
               _loc3_.MC_Info.MC_PackUp.visible = false;
               _loc3_.MC_Info.MC_Spread.visible = true;
               this.UpdateAttribute(_loc5_,_loc3_.MC_Info.MC_PackUp);
            }
            else
            {
               _loc3_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function UpdateAttribute(param1:TSoulArray, param2:MovieClip) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         _loc3_ = 0;
         while(_loc3_ < FORWARD_COUNT)
         {
            _loc5_ = Json.decode(param1.forwardAddition);
            _loc6_ = _loc5_[_loc3_];
            param2["TF_Forward" + _loc3_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc6_["tType"]);
            if(_loc6_["cType"] == 0)
            {
               param2["TF_ForwardValue" + _loc3_].text = String(int(_loc6_["tValue"]));
            }
            else
            {
               param2["TF_ForwardValue" + _loc3_].text = String(int(_loc6_["tValue"] * 100)) + "%";
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < MIDDLE_COUNT)
         {
            _loc5_ = Json.decode(param1.middleAddition);
            _loc6_ = _loc5_[_loc3_];
            param2["TF_Middle" + _loc3_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc6_["tType"]);
            if(_loc6_["cType"] == 0)
            {
               param2["TF_MiddleValue" + _loc3_].text = String(int(_loc6_["tValue"]));
            }
            else
            {
               param2["TF_MiddleValue" + _loc3_].text = String(int(_loc6_["tValue"] * 100)) + "%";
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < BACK_COUNT)
         {
            _loc5_ = Json.decode(param1.backAddition);
            _loc6_ = _loc5_[_loc3_];
            param2["TF_Back" + _loc3_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc6_["tType"]);
            if(_loc6_["cType"] == 0)
            {
               param2["TF_BackValue" + _loc3_].text = String(int(_loc6_["tValue"]));
            }
            else
            {
               param2["TF_BackValue" + _loc3_].text = String(int(_loc6_["tValue"] * 100)) + "%";
            }
            _loc3_++;
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FChangeTabIndex = param1 as int;
         this.FUIPage.Reset();
         this.FCurPage = 0;
         this.UpdateUI();
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateItem();
      }
      
      protected function ProcessorOnCancelUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * ITEM_COUNT;
         if(this.OnGetBox != null && _loc3_ < this.FCurInfo.length)
         {
            this.OnGetBox(REQ_OF_CANCEL,this.FCurInfo[_loc3_].Identifier);
         }
      }
      
      protected function ProcessorOnOpenUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * ITEM_COUNT;
         if(this.OnGetBox != null && _loc3_ < this.FCurInfo.length)
         {
            this.OnGetBox(REQ_OF_OPEN,this.FCurInfo[_loc3_].Identifier);
         }
      }
      
      protected function ProcessorOnAddUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * ITEM_COUNT;
         if(this.GotoAddSoul != null && _loc3_ < this.FCurInfo.length)
         {
            this.FPet.AddSoulFormation = this.FCurInfo[_loc3_];
            this.GotoAddSoul();
         }
      }
      
      protected function ProcessorOnActiveUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * ITEM_COUNT;
         if(this.OnGetBox != null && _loc3_ < this.FCurInfo.length)
         {
            this.OnGetBox(REQ_OF_ACTIVE,this.FCurInfo[_loc3_].Identifier);
         }
      }
      
      protected function ProcessorOnPackUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * ITEM_COUNT;
         if(_loc3_ < this.FCurInfo.length)
         {
            this.FMC_Scene["MC_Item" + _loc2_].MC_Info.MC_PackUp.visible = false;
            this.FMC_Scene["MC_Item" + _loc2_].MC_Info.MC_Spread.visible = true;
         }
      }
      
      protected function ProcessorOnSpreadUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.parent.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * ITEM_COUNT;
         if(_loc3_ < this.FCurInfo.length)
         {
            this.FMC_Scene["MC_Item" + _loc2_].MC_Info.MC_PackUp.visible = true;
            this.FMC_Scene["MC_Item" + _loc2_].MC_Info.MC_Spread.visible = false;
         }
      }
      
      protected function ProceossorOnSkillOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * ITEM_COUNT;
         if(this.OnShowHtmlTip != null && _loc3_ < this.FCurInfo.length)
         {
            this.FOverlayerSoulFormationSkill.Context = this.FCurInfo[_loc3_];
            this.FOverlayerSoulFormationSkill.Render(FUICore.MouseCoordinate);
            this.FOverlayerSoulFormationSkill.Show();
         }
      }
      
      protected function ProceossorOnSkillOut(param1:MouseEvent) : void
      {
         this.FOverlayerSoulFormationSkill.Hide();
      }
      
      protected function ProceossorOnMaxSkillOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Array = null;
         var _loc11_:TSoulArray = null;
         _loc2_ = int(String(param1.currentTarget.parent.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * ITEM_COUNT;
         if(this.OnShowHtmlTip != null && _loc3_ < this.FCurInfo.length)
         {
            _loc9_ = this.FCurInfo[_loc3_].Identifier - this.FCurInfo[_loc3_].level + MAX_LEVEL;
            _loc11_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,_loc9_) as TSoulArray;
            this.FOverlayerSoulFormationSkill.Context = _loc11_;
            this.FOverlayerSoulFormationSkill.Render(FUICore.MouseCoordinate);
            this.FOverlayerSoulFormationSkill.Show();
         }
      }
      
      public function UpdateUI() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TSoulArray = null;
         this.FCurInfo.length = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FPet.SoulFormations.length)
         {
            _loc3_ = this.FPet.SoulFormations[_loc1_];
            if(this.FChangeTabIndex == 0)
            {
               this.FCurInfo.push(_loc3_);
            }
            else if(_loc3_.type == this.FChangeTabIndex)
            {
               this.FCurInfo.push(_loc3_);
            }
            _loc1_++;
         }
         this.UpdateItem();
      }
   }
}

