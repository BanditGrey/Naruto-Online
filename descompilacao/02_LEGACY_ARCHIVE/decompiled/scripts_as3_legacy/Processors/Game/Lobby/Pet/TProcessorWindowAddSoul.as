package Processors.Game.Lobby.Pet
{
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TSoulArray;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.Exercise.TBaseActivity;
   import Logics.Pet.TPet;
   import Logics.SLogicsCore;
   import Logics.Streamization.Pet.TUnstreamizerAddSoul;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrameCopy;
   import Rendering.Overlayers.Pet.TOverlayerSoulFormationSkill;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_PET;
   import Resources.Strings.STRING_BASEACTIVITY;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_SOULFORMATION;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import ghostcat.util.data.Json;
   
   public class TProcessorWindowAddSoul extends TProcessorLobbyWindows
   {
      
      public static const BTN_COUNT:uint = 5;
      
      public static const FORWARD_COUNT:uint = 4;
      
      public static const MIDDLE_COUNT:uint = 3;
      
      public static const BACK_COUNT:uint = 2;
      
      public static const REQ_TYPE_1:int = 1;
      
      public static const REQ_TYPE_2:int = 2;
      
      public static const REQ_TYPE_3:int = 3;
      
      public static const REQ_TYPE_4:int = 4;
      
      public static const REQ_TYPE_5:int = 5;
      
      public static const REQ_TYPE_6:int = 6;
      
      public static const REQ_TYPE_7:int = 7;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FPet:TPet;
      
      protected var FHelpTips:THint;
      
      protected var FUnstreamizerAddSoul:TUnstreamizerAddSoul;
      
      protected var FProcessorWindowMysteryShop:TProcessorWindowMysteryShop;
      
      protected var FOverlayerSoulFormationSkill:TOverlayerSoulFormationSkill;
      
      protected var FMC_Mask:MovieClip;
      
      protected var FBarMaxWidth:int;
      
      protected var FCurInfo:TSoulArray;
      
      protected var FNextInfo:TSoulArray;
      
      public var GoSoulFormation:Function;
      
      public function TProcessorWindowAddSoul(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FPet = SLogicsCore.Character.Pet;
         this.FUnstreamizerAddSoul = new TUnstreamizerAddSoul();
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_AddSoul);
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
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_AddSoul") as MovieClip;
         addChild(this.FMC_Scene);
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         this.FMC_Mask = this.FMC_Scene.MC_Bar.MC_Mask;
         this.FBarMaxWidth = this.FMC_Mask.width;
         this.FProcessorWindowMysteryShop = new TProcessorWindowMysteryShop(this);
         this.FProcessorWindowMysteryShop.OnOverlay = UIComponentsHintOnOver;
         this.FProcessorWindowMysteryShop.OnOut = UIComponentsHintOnOut;
         this.FProcessorWindowMysteryShop.OnExchangeItem = this.ProcessorOnExhangeItem;
         this.FProcessorWindowMysteryShop.OnShowHtmlText = ProcessorOnShowHtmlText;
         this.FProcessorWindowMysteryShop.OnHideHtmlText = ProcessorOnHideHtmlText;
         this.FProcessorWindowMysteryShop.x = (CONST_COMMON.STAGE_Width - 573) / 2;
         this.FProcessorWindowMysteryShop.y = (CONST_COMMON.STAGE_Height - 390) / 2;
         this.FProcessorWindowMysteryShop.Init();
         this.FProcessorWindowMysteryShop.Visible = false;
         this.FOverlayerSoulFormationSkill = new TOverlayerSoulFormationSkill(this);
         this.FOverlayerSoulFormationSkill.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerSoulFormationSkill);
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < BTN_COUNT)
         {
            TGameUtil.setButtonMode(this.FMC_Scene["BTN_Buy" + _loc1_],true);
            this.FMC_Scene["BTN_Buy" + _loc1_].addEventListener(MouseEvent.CLICK,this.ProcessorOnBuyClick);
            this.FMC_Scene["BTN_Buy" + _loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.ProcessorOnBuyOver);
            this.FMC_Scene["BTN_Buy" + _loc1_].addEventListener(MouseEvent.ROLL_OUT,ProcessorOnHideHtmlText);
            _loc1_++;
         }
         this.FMC_Scene.MC_CurLevel.MC_SkillTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProceossorOnCurSkillOver);
         this.FMC_Scene.MC_CurLevel.MC_SkillTip.addEventListener(MouseEvent.ROLL_OUT,this.ProceossorOnCurSkillOut);
         this.FMC_Scene.MC_NextLevel.MC_SkillTip.addEventListener(MouseEvent.MOUSE_MOVE,this.ProceossorOnNextSkillOver);
         this.FMC_Scene.MC_NextLevel.MC_SkillTip.addEventListener(MouseEvent.ROLL_OUT,this.ProceossorOnNextSkillOut);
         TGameUtil.setButtonMode(this.FMC_Scene["BTN_Shop"],true);
         this.FMC_Scene["BTN_Shop"].addEventListener(MouseEvent.CLICK,this.ProcessorOnShopUp);
         this.FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
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
            if(this.FProcessorWindowMysteryShop != null && this.FProcessorWindowMysteryShop.Visible)
            {
               this.FProcessorWindowMysteryShop.LogicsPerform();
            }
         }
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AddSoul_LoadInfoRet,this.ProcessorOnLoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_AddSoul_CommonRet,this.ProcessorOnCommonRet);
         super.PacketRegisterRoutines();
      }
      
      protected function UpdateUI() : void
      {
         if(Boolean(this.FPet) && Boolean(this.FCurInfo))
         {
            this.UpdateText();
            this.UpdateLevel();
            if(this.FProcessorWindowMysteryShop.Visible)
            {
               this.FProcessorWindowMysteryShop.UpdateUI();
            }
         }
      }
      
      protected function UpdateText() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.FMC_Scene.MC_Pic.gotoAndStop(this.FCurInfo.resource);
         this.FMC_Scene.TF_Name.text = this.FCurInfo.name;
         this.FMC_Scene.TF_Type.text = (SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70101023 + this.FCurInfo.type - 1) as TSystemLanguage).Desc;
         this.FMC_Scene.TF_Level.text = this.FCurInfo.levelDescription;
         this.FMC_Scene.TF_Count.text = this.FPet.AddSoul.StoneCount.toString();
         this.FMC_Scene.BTN_Buy0.TF_LimitCount.text = this.FPet.AddSoul.GradeInfo[0].LimitCount.toString();
         this.FMC_Scene.TF_Exp.text = this.FCurInfo.CurExp + "/" + this.FCurInfo.needExp;
         _loc1_ = Number(this.FCurInfo.CurExp / this.FCurInfo.needExp) * this.FBarMaxWidth;
         _loc2_ = Math.min(_loc1_,this.FBarMaxWidth);
         this.FMC_Mask.width = _loc2_;
      }
      
      protected function UpdateLevel() : void
      {
         this.UpdateAttribute(this.FCurInfo,this.FMC_Scene.MC_CurLevel);
         this.FNextInfo = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,this.FCurInfo.Identifier + 1) as TSoulArray;
         if(this.FNextInfo != null)
         {
            this.FMC_Scene.MC_End.visible = false;
            this.UpdateAttribute(this.FNextInfo,this.FMC_Scene.MC_NextLevel,true);
         }
         else
         {
            this.FNextInfo = this.FCurInfo;
            this.FMC_Scene.MC_End.visible = true;
         }
      }
      
      protected function UpdateAttribute(param1:TSoulArray, param2:MovieClip, param3:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc8_:Object = null;
         var _loc9_:Object = null;
         param2.TF_Skill.text = param1.SkillName;
         if(!param3)
         {
            _loc4_ = 0;
            while(_loc4_ < FORWARD_COUNT)
            {
               _loc6_ = Json.decode(param1.forwardAddition);
               _loc8_ = _loc6_[_loc4_];
               param2["TF_Forward" + _loc4_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc8_["tType"]);
               this.SetText(param2["TF_ForwardValue" + _loc4_],_loc8_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < MIDDLE_COUNT)
            {
               _loc6_ = Json.decode(param1.middleAddition);
               _loc8_ = _loc6_[_loc4_];
               param2["TF_Middle" + _loc4_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc8_["tType"]);
               this.SetText(param2["TF_MiddleValue" + _loc4_],_loc8_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < BACK_COUNT)
            {
               _loc6_ = Json.decode(param1.backAddition);
               _loc8_ = _loc6_[_loc4_];
               param2["TF_Back" + _loc4_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc8_["tType"]);
               this.SetText(param2["TF_BackValue" + _loc4_],_loc8_);
               _loc4_++;
            }
         }
         else
         {
            _loc4_ = 0;
            while(_loc4_ < FORWARD_COUNT)
            {
               _loc6_ = Json.decode(this.FCurInfo.forwardAddition);
               _loc8_ = _loc6_[_loc4_];
               _loc7_ = Json.decode(param1.forwardAddition);
               _loc9_ = _loc7_[_loc4_];
               param2["TF_Forward" + _loc4_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc9_["tType"]);
               this.SetText(param2["TF_ForwardValue" + _loc4_],_loc8_,_loc9_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < MIDDLE_COUNT)
            {
               _loc6_ = Json.decode(this.FCurInfo.middleAddition);
               _loc8_ = _loc6_[_loc4_];
               _loc7_ = Json.decode(param1.middleAddition);
               _loc9_ = _loc7_[_loc4_];
               param2["TF_Middle" + _loc4_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc9_["tType"]);
               this.SetText(param2["TF_MiddleValue" + _loc4_],_loc8_,_loc9_);
               _loc4_++;
            }
            _loc4_ = 0;
            while(_loc4_ < BACK_COUNT)
            {
               _loc6_ = Json.decode(this.FCurInfo.backAddition);
               _loc8_ = _loc6_[_loc4_];
               _loc7_ = Json.decode(param1.backAddition);
               _loc9_ = _loc7_[_loc4_];
               param2["TF_Back" + _loc4_].text = STRING_COMMON.GetBaseAttributeNameByType(_loc9_["tType"]);
               this.SetText(param2["TF_BackValue" + _loc4_],_loc8_,_loc9_);
               _loc4_++;
            }
         }
      }
      
      public function SetText(param1:TextField, param2:Object, param3:Object = null) : void
      {
         if(param3 == null)
         {
            if(param2["cType"] == 0)
            {
               param1.htmlText = String(int(param2["tValue"]));
            }
            else
            {
               param1.htmlText = String(int(param2["tValue"] * 100)) + "%";
            }
         }
         else if(param2["cType"] == 0)
         {
            if(param2["tValue"] < param3["tValue"])
            {
               param1.htmlText = "<font color=\"#6CFF00\">" + String(int(param3["tValue"])) + "</font>";
            }
            else
            {
               param1.htmlText = String(int(param3["tValue"]));
            }
         }
         else if(param2["tValue"] < param3["tValue"])
         {
            param1.htmlText = "<font color=\"#6CFF00\">" + String(int(param3["tValue"] * 100)) + "%" + "</font>";
         }
         else
         {
            param1.htmlText = String(int(param3["tValue"] * 100)) + "%";
         }
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:int = 0;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AddSoul_LoadInfoReq);
         _loc1_.Data.writeInt(this.FCurInfo.Identifier);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PerformPacket_CS_AllReq(param1:int, param2:Vector.<int> = null) : void
      {
         var _loc3_:TPacket = null;
         var _loc4_:ByteArray = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_AddSoul_CommonReq);
         _loc3_.Data.writeUnsignedInt(param1);
         if(param2 == null)
         {
            _loc3_.Data.writeShort(0);
         }
         else
         {
            _loc6_ = int(param2.length);
            _loc3_.Data.writeShort(_loc6_);
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc3_.Data.writeUnsignedInt(param2[_loc5_]);
               _loc5_++;
            }
         }
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      override protected function ProcessorOnGetBoxClick(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc4_:TPacket = null;
         var _loc5_:int = 0;
         var _loc6_:Vector.<int> = null;
         if(FIsClicked)
         {
            return;
         }
         FIsClicked = true;
         _loc6_ = new Vector.<int>();
         if(param2 != 0)
         {
            _loc6_.push(param2);
         }
         if(param3 != 0)
         {
            _loc6_.push(param3);
         }
         this.PerformPacket_CS_AllReq(param1,_loc6_);
      }
      
      protected function ProcessorOnBuyClick(param1:MouseEvent) : void
      {
         if(!param1.currentTarget.buttonMode)
         {
            return;
         }
         switch(param1.currentTarget.name)
         {
            case "BTN_Buy0":
               this.ProcessorOnGetBoxClick(REQ_TYPE_1,this.FCurInfo.Identifier);
               break;
            case "BTN_Buy1":
               ProcessorOnBuyBoxClick(REQ_TYPE_2,this.FPet.AddSoul.GradeInfo[1].Price,this.FCurInfo.Identifier,TBaseActivity.SWEET_TYPE_GOLD_GIFT);
               break;
            case "BTN_Buy2":
               ProcessorOnBuyBoxClick(REQ_TYPE_3,this.FPet.AddSoul.GradeInfo[2].Price,this.FCurInfo.Identifier,TBaseActivity.SWEET_TYPE_GOLD_GIFT);
               break;
            case "BTN_Buy3":
               this.ProcessorOnGetBoxClick(REQ_TYPE_4,this.FCurInfo.Identifier);
               break;
            case "BTN_Buy4":
               this.ProcessorOnGetBoxClick(REQ_TYPE_5,this.FCurInfo.Identifier);
         }
      }
      
      protected function ProcessorOnExhangeItem(param1:int, param2:int = 0) : void
      {
         this.ProcessorOnGetBoxClick(param1,param2);
      }
      
      protected function ProcessorOnShopUp(param1:MouseEvent) : void
      {
         this.FProcessorWindowMysteryShop.Visible = true;
      }
      
      protected function ProceossorOnCurSkillOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         if(this.FCurInfo != null)
         {
            this.FOverlayerSoulFormationSkill.Context = this.FCurInfo;
            this.FOverlayerSoulFormationSkill.Render(FUICore.MouseCoordinate);
            this.FOverlayerSoulFormationSkill.Show();
         }
      }
      
      protected function ProceossorOnCurSkillOut(param1:MouseEvent) : void
      {
         this.FOverlayerSoulFormationSkill.Hide();
      }
      
      protected function ProcessorOnBuyOver(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(Boolean(this.FCurInfo) && this.FPet.AddSoul.GradeInfo.length > 0)
         {
            switch(param1.currentTarget.name)
            {
               case "BTN_Buy0":
                  _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_008).DescribeString;
                  _loc2_ = TUtilityString.Format(_loc2_,this.FPet.AddSoul.GradeInfo[0].Price,this.FPet.AddSoul.GradeInfo[0].LimitCount);
                  break;
               case "BTN_Buy1":
                  _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_009).DescribeString;
                  _loc2_ = TUtilityString.Format(_loc2_,this.FPet.AddSoul.GradeInfo[1].Price,this.FPet.AddSoul.GradeInfo[1].LimitCount);
                  break;
               case "BTN_Buy2":
                  _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_010).DescribeString;
                  _loc2_ = TUtilityString.Format(_loc2_,this.FPet.AddSoul.GradeInfo[2].Price,this.FPet.AddSoul.GradeInfo[2].LimitCount);
                  break;
               case "BTN_Buy3":
                  _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_006).DescribeString;
                  _loc2_ = TUtilityString.Format(_loc2_,this.FPet.AddSoul.GradeInfo[3].Price,this.FPet.AddSoul.GradeInfo[3].Level);
                  break;
               case "BTN_Buy4":
                  _loc2_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_007).DescribeString;
                  _loc2_ = TUtilityString.Format(_loc2_,this.FPet.AddSoul.GradeInfo[4].Price,this.FPet.AddSoul.GradeInfo[4].Level);
            }
            ProcessorOnShowHtmlText(_loc2_);
         }
      }
      
      protected function ProceossorOnNextSkillOver(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         if(this.FNextInfo != null)
         {
            this.FOverlayerSoulFormationSkill.Context = this.FNextInfo;
            this.FOverlayerSoulFormationSkill.Render(FUICore.MouseCoordinate);
            this.FOverlayerSoulFormationSkill.Show();
         }
      }
      
      protected function ProceossorOnNextSkillOut(param1:MouseEvent) : void
      {
         this.FOverlayerSoulFormationSkill.Hide();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = null;
         _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,70170094) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
         this.GoSoulFormation(this);
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         this.FCurInfo = this.FPet.AddSoulFormation;
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      protected function ProcessorOnLoadInfoRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FUnstreamizerAddSoul.Unstreamize(_loc2_,this.FPet,null);
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
         }
      }
      
      protected function ProcessorOnCommonRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         var _loc10_:int = 0;
         FIsClicked = false;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         _loc4_ = int(_loc2_.readUnsignedInt());
         _loc2_.readShort();
         switch(_loc4_)
         {
            case REQ_TYPE_1:
            case REQ_TYPE_2:
            case REQ_TYPE_3:
            case REQ_TYPE_4:
            case REQ_TYPE_5:
               _loc5_ = int(_loc2_.readUnsignedInt());
               _loc6_ = int(_loc2_.readUnsignedInt());
               _loc7_ = int(_loc2_.readUnsignedInt());
               this.FPet.AddSoul.StoneCount = _loc2_.readUnsignedInt();
               --this.FPet.AddSoul.GradeInfo[_loc4_ - 1].LimitCount;
               if(_loc5_ == _loc6_)
               {
                  this.FCurInfo.CurExp = _loc7_;
                  _loc9_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_004).DescribeString;
                  _loc9_ = TUtilityString.Format(_loc9_,this.FPet.AddSoul.GradeInfo[_loc4_ - 1].Level);
                  EffectGenerateText(_loc9_);
                  this.UpdateUI();
               }
               else
               {
                  _loc10_ = this.FPet.GetSoulFormationIndexByIdentify(_loc5_);
                  this.FPet.SoulFormations[_loc10_] = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SoulArray,_loc6_) as TSoulArray;
                  this.FPet.SoulFormations[_loc10_].CurExp = _loc7_;
                  this.FCurInfo = this.FPet.AddSoulFormation = this.FPet.SoulFormations[_loc10_];
                  _loc9_ = new ConsumeFrameCopy(STRING_SOULFORMATION.STRING_005).DescribeString;
                  _loc9_ = TUtilityString.Format(_loc9_,this.FPet.AddSoul.GradeInfo[_loc4_ - 1].Level);
                  EffectGenerateText(_loc9_);
                  this.UpdateUI();
               }
               break;
            case REQ_TYPE_6:
               _loc10_ = _loc2_.readUnsignedInt() - 1;
               this.FPet.AddSoul.StoneCount = _loc2_.readUnsignedInt();
               _loc9_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               EffectGenerateText(_loc9_);
               this.UpdateUI();
               break;
            case REQ_TYPE_7:
               this.FPet.AddSoul.StoneCount = _loc2_.readUnsignedInt();
               --this.FPet.AddSoul.DayItemLimit;
               _loc9_ = STRING_BASEACTIVITY.FORMAT_EXCHANGE;
               EffectGenerateText(_loc9_);
               this.UpdateUI();
         }
      }
   }
}

